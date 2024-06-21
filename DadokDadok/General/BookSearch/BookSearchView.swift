//
//  BookSearchView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/01.
//

import SwiftUI

struct BookSearchView: View {
    @StateObject private var requestAPI = RequestAPI.shared
    @State private var searchKeyword = ""
    @State private var tappedBook: Book?
    @Binding var isPresentingBookSearchView: Bool
    @Binding var selectedBook: Book?
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                SearchBar(text: $searchKeyword)
                
                Button {
                    requestAPI.requestSearchBookList(query: searchKeyword)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(ColorManager.accentColor)
                }
            }
            .padding(.horizontal, 5)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(requestAPI.bookList, id: \.self) { book in
                        BookSearchRowView(book: book, isTapped: book == tappedBook)
                            .onTapGesture {
                                tappedBook = book
                                selectedBook = book
                                isPresentingBookSearchView = false
                            }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .onSubmit {
            requestAPI.requestSearchBookList(query: searchKeyword)
        }
        .onDisappear {
            requestAPI.bookList = []
        }
    }
}
