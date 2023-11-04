//
//  ReviewViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/04.
//

import SwiftUI
import Combine

final class ReviewViewModel: ObservableObject {
    
    @Published var reviewList: Binding<[BookReview]>
    @Published var bookReview: BookReview = BookReview.emptyReview
    @Published var title: String = ""
    @Published var date: Date = Date()
    @Published var review: String = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    init(reviewList: Binding<[BookReview]>) {
        self.reviewList = reviewList
        
        $title.sink { title in
            self.update(title: title)
        }.store(in: &subscriptions)
       
        $date.sink { date in
            self.update(date: date)
        }.store(in: &subscriptions)
        
        $review.sink { review in
            self.update(review: review)
        }.store(in: &subscriptions)
    }
    
    func update(title: String) {
        self.bookReview.title = title
    }
  
    func update(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.bookReview.date = formatter.string(from: date)
    }
    
    func update(review: String) {
        self.bookReview.review = review
    }
    
    func completed() {
        guard bookReview.date.isEmpty == false else { return }
        reviewList.wrappedValue.append(bookReview)
    }
}
