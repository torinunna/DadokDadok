//
//  ReviewListView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct ReviewListView: View {
    @Binding var reviews: [BookReview]
    
    var body: some View {
        NavigationStack {
            List($reviews) { $review in
                NavigationLink(destination: ReviewDetailView(review: $review)) {
                    ReviewCard(review: review)
                }
            }
            .navigationTitle("나의 서평")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView(reviews: .constant(BookReview.sampleData))
    }
}
