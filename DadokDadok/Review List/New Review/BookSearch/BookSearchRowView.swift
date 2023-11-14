//
//  BookSearchRowView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/02.
//

import SwiftUI

struct BookSearchRowView: View {
    var book: Book
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            fetchImage(url: book.image)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(book.title)
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.vertical, 3)
                Text(book.author)
                    .font(.system(size: 11))
                Text(book.publisher)
                    .font(.system(size: 11))
            }
            .padding(.vertical)
        }
        .frame(alignment: .leading)
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 70, height: 90)
    }
}
