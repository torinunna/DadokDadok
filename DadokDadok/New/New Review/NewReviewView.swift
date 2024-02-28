//
//  NewReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/10/01.
//

import SwiftUI

struct NewReviewView: View {
    @StateObject var vm: NewReviewViewModel
    @Binding var isPresentingNewReviewView: Bool
    @State private var isPresentingBookSearchView = false
    @State private var selectedBook: Book?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
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
                    .disabled(selectedBook == nil || vm.review.isEmpty)
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


