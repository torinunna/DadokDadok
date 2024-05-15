//
//  BookCover.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/16/24.
//

import SwiftUI

struct BookCover: View {
    let bookReview: BookReview
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            fetchImage(url: bookReview.book.image)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(bookReview.book.title)
                    .font(.system(size: 14, weight: .semibold))
                    .fontWeight(.semibold)
                    .padding(.vertical, 7)
                
                Text(bookReview.book.author)
                    .font(.system(size: 12))
                    .padding(.top, 5)
                
                Text(bookReview.book.publisher)
                    .font(.system(size: 12))
                    .padding(.top, 2)
                    .padding(.bottom, 5)
            }
        }
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(maxWidth: 70, maxHeight: 100)
        .shadow(radius: 5)
    }
}

#Preview {
    BookCover(bookReview: BookReview.sampleData[0])
}
