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
        HStack(alignment: .center) {
            URLImage(urlString: book.image)
            
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
            
            Spacer()
        }
        .frame(alignment: .leading)
        .padding(.horizontal, 5)
    }
}
