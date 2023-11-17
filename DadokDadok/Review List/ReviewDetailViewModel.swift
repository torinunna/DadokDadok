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
    @Published var bookReview: BookReview
    
    init(reviewList: Binding<[BookReview]>, bookReview: BookReview) {
        self.reviewList = reviewList
        self.bookReview = bookReview
    }
    
    func delete() {
        reviewList.wrappedValue = reviewList.wrappedValue.filter { $0.id != bookReview.id }
    }
}
