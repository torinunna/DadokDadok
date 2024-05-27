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
    
    init(bookReviews: Binding<[BookReview]>, bookReview: BookReview) {
        self.bookReviews = bookReviews
        self.bookReview = bookReview
    }
    
    func fetch() {
        guard let index = bookReviews.wrappedValue.firstIndex(where: { $0.id == bookReview.id }) else {
            return
        }
        
        let updatedReview = Storage.retrive("review_list.json", from: .documents, as: [BookReview].self)?
            .first(where: { $0.id == bookReview.id })
        
        if let updatedReview = updatedReview {
            bookReviews.wrappedValue[index] = updatedReview
            bookReview = updatedReview
        }
    }
    
    func delete() {
        bookReviews.wrappedValue = bookReviews.wrappedValue.filter { $0.id != bookReview.id }
        Storage.store(bookReviews.wrappedValue, to: .documents, as: "review_list.json")
    }
}
