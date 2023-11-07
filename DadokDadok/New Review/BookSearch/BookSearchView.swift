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
    
    var body: some View {
        NavigationStack {
            List(requestAPI.bookList, id: \.self) { book in
                BookSearchRowView(book: book)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .searchable(text: $searchKeyword, placement: .navigationBarDrawer(displayMode: .always), prompt: "도서명/저자/출판사를 입력해주세요")
            .navigationTitle("도서 검색")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onSubmit(of: .search) {
            requestAPI.requestSearchBookList(query: searchKeyword)
        }
    }
}

struct BookSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView()
    }
}