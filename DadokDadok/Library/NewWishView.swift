//
//  NewWishView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/31/23.
//

import SwiftUI

struct NewWishView: View {
    @State private var newWish = Wish.emptyWish
    @Binding var isPresentingNewWishView: Bool
    @Binding var wishList: [Wish]
    @State private var isPresentingBookSearchView = false
    @State private var selectedView: Views = .searchBookView
    @State private var selectedBook: Book?
    
    enum Views {
        case searchBookView
        case userInputView
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("select view", selection: $selectedView) {
                    Text("책 검색하기").tag(Views.searchBookView)
                    Text("직접 입력하기").tag(Views.userInputView)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                if selectedView == .searchBookView {
                    SearchView(selectedBook: $selectedBook)
                } else {
                    UserInputView()
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
                        wishList.append(newWish)
                        isPresentingNewWishView = false
                    }
                }
            }
            .navigationTitle("읽고 싶은 책")
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
                    Button {
                        requestAPI.requestSearchBookList(query: searchKeyword)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.secondary)
                    }
                    
                    TextField("도서명/저자/출판사를 입력해주세요.", text: $searchKeyword)
                        .foregroundStyle(Color.primary)
                }
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                
                ForEach(requestAPI.bookList, id: \.self) { book in
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: selectedBook == book ? "checkmark.square.fill" : "checkmark.square")
                        BookSearchRowView(book: book)
                    }
                    .onTapGesture {
                        selectedBook = book
                        print("Book selected: \(book.title)")
                    }
                }
            }
            .padding(.horizontal, 15)
        }
    }
}


// MARK: - User Input

struct UserInputView: View {
    @State private var title = ""
    @State private var author = ""
    @State private var publisher = ""
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.secondary.opacity(0.2))
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                Image(systemName: "camera")
                    .foregroundStyle(Color.white)
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            TextField("도서 제목", text: $title)
                .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Color.gray, lineWidth: 1)
                )
            TextField("저자", text: $author)
                .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Color.gray, lineWidth: 1)
                )
            TextField("출판사", text: $publisher)
                .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
