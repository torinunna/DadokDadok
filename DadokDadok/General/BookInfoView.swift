//
//  BookInfoView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/16/24.
//

import SwiftUI

struct BookInfoView: View {
    let bookReview: BookReview
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            BookCover(imageString: bookReview.book.image)
                .frame(width: 70, height: 100)
                .shadow(radius: 5)
            
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
}

#Preview {
    BookInfoView(bookReview: BookReview.sampleData[0])
}
