//
//  ReviewCard.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct ReviewCard: View {
    var bookReview: BookReview

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            fetchImage(url: bookReview.imageName)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(bookReview.date)
                    .font(.system(size: 11))
                Text(bookReview.title)
                    .font(.system(size: 14, weight: .semibold))
                    .multilineTextAlignment(.leading)
                Text("\(bookReview.author) | \(bookReview.publisher)")
                    .font(.system(size: 12))
                Text(bookReview.isbn)
                    .font(.system(size: 12))
            }
            .foregroundStyle(.black)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(width: 60, height: 80)
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var review = BookReview.sampleData[0]
    
    static var previews: some View {
        ReviewCard(bookReview: review)
    }
}
