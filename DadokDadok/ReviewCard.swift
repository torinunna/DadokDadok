//
//  ReviewCard.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct ReviewCard: View {
    var review: BookReview

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: review.imageName)
                .resizable()
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(review.title)
                    .font(.headline)
                Text(review.date)
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var review = BookReview.sampleData[0]
    
    static var previews: some View {
        ReviewCard(review: review)
    }
}
