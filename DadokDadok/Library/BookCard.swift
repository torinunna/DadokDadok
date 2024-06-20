//
//  BookView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct BookCard: View {
    var bookReview: BookReview
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.cardColor.opacity(0.2))
                .shadow(color: .gray, radius: 3, x: 0, y: 2)
            
            VStack(alignment: .center, spacing: 15) {
                BookCover(imageString: bookReview.book.image)
                    .frame(height: 90)
                
                Text(bookReview.book.title)
                    .font(.system(size: 12.0, weight: .bold))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(ColorManager.accentColor)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
        }
    }
}
