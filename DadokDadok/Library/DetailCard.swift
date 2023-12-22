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
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
                .frame(minHeight: 50)
                
            HStack(alignment: .center, spacing: 15) {
                Text(bookReview.date)
                    .font(.system(size: 13, weight: .medium))
                    .padding(.leading)
                
                Divider()
                    .overlay(Color.white)
                
                Text(bookReview.review)
                    .font(.system(size: 13))
                    .lineLimit(5)
                
                Spacer()
            }
            .foregroundStyle(Color.black)
            .padding(.vertical, 10)
        }
    }
}

struct DetailCard_Previews: PreviewProvider {
    static var previews: some View {
        DetailCard(bookReview: BookReview.sampleData.first!)
    }
}
