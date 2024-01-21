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
                .fill(ColorManager.cardColor.opacity(0.1))
            
            VStack(alignment: .center, spacing: 15) {
                fetchImage(url: bookReview.book.image)
                
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
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 5)
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(height: 90)
    }
}
