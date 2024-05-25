//
//  NewReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/10/01.
//

import SwiftUI
import PhotosUI

struct NewReviewView: View {
    @StateObject var vm: NewReviewViewModel
    @Binding var isPresentingNewReviewView: Bool
    @State private var isPresentingBookSearchView = false
    @State private var selectedBook: Book?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Picker("select view", selection: $vm.selectedView) {
                    Text("책 검색하기")
                        .tag(Views.searchBookView)
                    Text("직접 입력하기")
                        .tag(Views.userInputView)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                if vm.selectedView == .searchBookView {
                    if let selectedBook = selectedBook {
                        BookInfoView(book: selectedBook, isPresentingBookSearchView: $isPresentingBookSearchView)
                            .onAppear {
                                vm.update(book: selectedBook)
                            }
                    } else {
                        HStack(alignment: .center, spacing: 20) {
                            Image(systemName: "book")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 80)
                                .padding(.horizontal)
                            
                            Button {
                                isPresentingBookSearchView = true
                            } label: {
                                HStack {
                                    Text("도서 검색")
                                    Spacer()
                                    Image(systemName: "magnifyingglass")
                                }
                                .foregroundStyle(Color.secondary)
                            }
                        }
                    }
                } else {
                    UserBookInputView(imageString: $vm.book.image, title: $vm.book.title, author: $vm.book.author, publisher: $vm.book.publisher)
                }
                
                DatePicker("읽은 날짜", selection: $vm.date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .environment(\.locale, Locale.init(identifier: "ko-KR"))
                
                ReviewInputView(text: $vm.review)
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $isPresentingBookSearchView) {
                BookSearchView(isPresentingBookSearchView: $isPresentingBookSearchView, selectedBook: $selectedBook)
            }
            .navigationTitle("서평 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        isPresentingNewReviewView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        vm.completed()
                        isPresentingNewReviewView = false
                    }
                    .disabled(vm.selectedView == .searchBookView && selectedBook == nil || vm.selectedView == .userInputView && vm.book.title.isEmpty || vm.bookReview.review.isEmpty)
                }
            }
        }
    }
    
    
}

// MARK: - Book Info View

struct BookInfoView: View {
    let book: Book
    @Binding var isPresentingBookSearchView: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            fetchImage(url: book.image)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(book.title)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.bottom, 3)
                    .lineLimit(3)
                Text("\(book.author) | \(book.publisher)")
                    .font(.system(size: 13))
                Text(book.isbn)
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            Button {
                isPresentingBookSearchView = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 60, height: 80)
    }
}


// MARK: - Review Input View

struct ReviewInputView: View {
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            let placeholder = "서평을 남겨주세요!"
            
            TextEditor(text: $text)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black.opacity(0.25), lineWidth: 1)
                )
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(Color.primary.opacity(0.25))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
        }
    }
}


// MARK: - User Book Input View

struct UserBookInputView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @Binding var imageString: String
    @Binding var title: String
    @Binding var author: String
    @Binding var publisher: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(ColorManager.cardColor.opacity(0.2))
                    .frame(width: 100, height: 120)
                
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 120)
                } else {
                    PhotosPicker(selection: $selectedItem) {
                        VStack(spacing: 15) {
                            Image(systemName: "camera")
                            Text("사진을 선택해주세요.")
                                .font(.system(size: 10))
                        }
                        .foregroundStyle(Color.primary.opacity(0.4))
                    }
                    .onChange(of: selectedItem) { _ in
                        Task {
                            if let selectedItem,
                               let data = try? await selectedItem.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    selectedImage = image
                                    imageString = data.base64EncodedString()
                                }
                            }
                        }
                    }
                }
            }
            
            VStack {
                TextField("도서명", text: $title)
                    .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(ColorManager.accentColor, lineWidth: 0.5)
                    )
                
                TextField("저자", text: $author)
                    .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(ColorManager.accentColor, lineWidth: 0.5)
                    )
                
                TextField("출판사", text: $publisher)
                    .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(ColorManager.accentColor, lineWidth: 0.5)
                    )
            }
        }
        .frame(height: 120)
    }
}
