//
//  ReviewDetailViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/15.
//

import Foundation
import SwiftUI

final class ReviewDetailViewModel: ObservableObject {
    @Published var reviewList: Binding<[BookReview]>
    @Published var review: BookReview
    
    init(reviewList: Binding<[BookReview]>, review: BookReview) {
        self.reviewList = reviewList
        self.review = review
    }
    
    func delete() {
        reviewList.wrappedValue = reviewList.wrappedValue.filter { $0.id != review.id }
    }
}
