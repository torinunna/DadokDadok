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
                    Button("Dismiss") {
                        isPresentingNewWishView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        wishList.append(newWish)
                        isPresentingNewWishView = false
                    }
                }
            }
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
    var body: some View {
        Text("User Input View")
        
    }
}
