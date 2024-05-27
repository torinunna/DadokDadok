//
//  NewWishView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/31/23.
//

import SwiftUI
import PhotosUI

struct NewWishView: View {
    @StateObject var vm: NewWishViewModel
    @Binding var isPresentingNewWishView: Bool
    @State private var selectedBook: Book?

    var body: some View {
        NavigationStack {
            VStack {
                ViewPicker(selectedView: $vm.selectedView)
                
                if vm.selectedView == .searchBookView {
                    SearchView(selectedBook: $selectedBook)
                        .onDisappear {
                            selectedBook = nil
                        }
                } else {
                    UserInputView(imageString: $vm.book.image, title: $vm.book.title, author: $vm.book.author, publisher: $vm.book.publisher)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        isPresentingNewWishView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가하기") {
                        if let selectedBook {
                            vm.update(book: selectedBook)
                            vm.completed()
                            isPresentingNewWishView = false
                        } else {
                            vm.completed()
                            isPresentingNewWishView = false
                        }
                    }
                    .disabled(vm.selectedView == .searchBookView && selectedBook == nil || vm.selectedView == .userInputView && vm.wish.book.title.isEmpty)
                }
            }
            .navigationTitle("읽을 책")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Search View

struct SearchView: View {
    @State private var searchKeyword = ""
    @ObservedObject var requestAPI = RequestAPI.shared
    @Binding var selectedBook: Book?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    TextField("도서명/저자/출판사를 입력해주세요.", text: $searchKeyword) {
                        requestAPI.requestSearchBookList(query: searchKeyword)
                    }
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .foregroundColor(.primary)
                    .background(ColorManager.cardColor.opacity(0.2))
                    .cornerRadius(10.0)
                    
                    Button {
                        requestAPI.requestSearchBookList(query: searchKeyword)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(ColorManager.accentColor)
                    }
                }
                
                ForEach(requestAPI.bookList, id: \.self) { book in
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: selectedBook == book ? "checkmark.square.fill" : "checkmark.square")
                            .foregroundStyle(ColorManager.accentColor)
                        BookSearchRowView(book: book)
                    }
                    .onTapGesture {
                        if selectedBook == book {
                            selectedBook = nil
                        } else {
                            selectedBook = book
                            print("Book selected: \(book.title)")
                        }
                    }
                }
                .onDisappear {
                    requestAPI.bookList = []
                }
            }
            .padding(.horizontal, 15)
        }
    }
}


// MARK: - User Input

struct UserInputView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @Binding var imageString: String
    @Binding var title: String
    @Binding var author: String
    @Binding var publisher: String
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(ColorManager.cardColor.opacity(0.2))
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
                
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 280)
                        .frame(maxWidth: .infinity)
                } else {
                    PhotosPicker(selection: $selectedItem) {
                        VStack(spacing: 15) {
                            Image(systemName: "camera")
                            Text("사진을 선택해주세요.")
                                .font(.caption)
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
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("* 필수")
                    .font(.caption2)
                TextField("도서 제목", text: $title)
                    .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(ColorManager.accentColor, lineWidth: 1)
                    )
            }
            
            TextField("저자", text: $author)
                .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(ColorManager.accentColor, lineWidth: 1)
                )
            
            TextField("출판사", text: $publisher)
                .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(ColorManager.accentColor, lineWidth: 1)
                )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
