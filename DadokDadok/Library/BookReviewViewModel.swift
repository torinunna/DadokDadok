//
//  BookReviewViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/15.
//

import Foundation
import SwiftUI

final class BookReviewViewModel: ObservableObject {
    @Published var bookReviews: Binding<[BookReview]>
    @Published var bookReview: BookReview
    @Published var reviewDate: Date

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }()
    
    init(bookReviews: Binding<[BookReview]>, bookReview: BookReview) {
        self.bookReviews = bookReviews
        self.bookReview = bookReview
        
        if let date = BookReviewViewModel.dateFormatter.date(from: bookReview.date) {
            self.reviewDate = date
        } else {
            self.reviewDate = Date()
        }
    }
    
    func fetch() {
        guard let index = bookReviews.wrappedValue.firstIndex(where: { $0.id == bookReview.id }) else {
            return
        }
        
        let updatedReview = Storage.retrieve("review_list.json", from: .documents, as: [BookReview].self)?
            .first(where: { $0.id == bookReview.id })
        
        if let updatedReview = updatedReview {
            bookReviews.wrappedValue[index] = updatedReview
            bookReview = updatedReview
            
            if let date = BookReviewViewModel.dateFormatter.date(from: updatedReview.date) {
                reviewDate = date
            }
        }
    }
    
    func delete() {
        bookReviews.wrappedValue = bookReviews.wrappedValue.filter { $0.id != bookReview.id }
        Storage.store(bookReviews.wrappedValue, to: .documents, as: "review_list.json")
    }
    
    func save() {
        bookReview.date = BookReviewViewModel.dateFormatter.string(from: reviewDate)
        guard let index = bookReviews.wrappedValue.firstIndex(where: { $0.id == bookReview.id }) else {
            return
        }
        bookReviews.wrappedValue[index] = bookReview
        Storage.store(bookReviews.wrappedValue, to: .documents, as: "review_list.json")
    }
}
