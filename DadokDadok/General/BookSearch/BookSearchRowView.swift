//
//  BookSearchRowView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/02.
//

import SwiftUI

struct BookSearchRowView: View {
    var book: Book
    var isTapped: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 15) {
                BookCover(imageString: book.image)
                    .frame(width: 70, height: 90)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(book.title)
                        .font(.system(size: 13, weight: .semibold))
                        .padding(.vertical, 3)
                    Text(book.author)
                        .font(.system(size: 11))
                    Text(book.publisher)
                        .font(.system(size: 11))
                    Text(book.isbn)
                        .font(.system(size: 10))
                }
               
                Spacer()
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity)
        .background(isTapped ? ColorManager.cardColor.opacity(0.2) : Color.clear)
        .cornerRadius(8)
    }
}
