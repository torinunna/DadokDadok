//
//  DetailCard.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 11/27/23.
//

import SwiftUI

struct DetailCard: View {
    var bookReview: BookReview
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Text(bookReview.date)
                .font(.system(size: 14, weight: .medium))
            Text(bookReview.review)
                .font(.system(size: 13))
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

struct DetailCard_Previews: PreviewProvider {
    static var previews: some View {
        DetailCard(bookReview: BookReview.sampleData.first!)
    }
}
