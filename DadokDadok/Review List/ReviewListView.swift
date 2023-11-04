//
//  ReviewListView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct ReviewListView: View {
    @Binding var reviews: [BookReview]
    @State private var isPresentingNewReviewView = false
    
    var body: some View {
        List($reviews) { $review in
            NavigationLink(destination: ReviewDetailView(review: $review, reviews: $reviews)) {
                ReviewCard(review: review)
            }
        }
        .toolbar {
            Button(action: {
                isPresentingNewReviewView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewReviewView) {
            let vm = ReviewViewModel(reviewList: $reviews)
            NewReviewView(vm: vm, isPresentingNewReviewView: $isPresentingNewReviewView)
        }
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView(reviews: .constant(BookReview.sampleData))
    }
}
