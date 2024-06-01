//
//  LibraryDetailViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import Foundation
import SwiftUI

final class LibraryDetailViewModel: ObservableObject {
    enum SortingOrder {
        case ascending, descending
    }
    
    @Published var bookReviews: [BookReview] = []
    @Published var bookReview: BookReview
    @Published var sortingOrder: SortingOrder = .descending
    
    private var container: DIContainer
    
    init(bookReviews: [BookReview], bookReview: BookReview, container: DIContainer) {
        self.bookReviews = bookReviews
        self.bookReview = bookReview
        self.container = container
    }
    
    var filteredReviews: [BookReview] {
        let identifier = bookReview.book.isbn.isEmpty ? bookReview.book.title : bookReview.book.isbn
        return bookReviews.filter { review in
            let reviewIdentifier = review.book.isbn.isEmpty ? review.book.title : review.book.isbn
            return reviewIdentifier == identifier
        }
    }
    
    var filteredReviewsCount: Int {
        filteredReviews.count
    }
    
    func sortOrder() {
        sortingOrder = (sortingOrder == .ascending) ? .descending : .ascending
        sortBookReviews()
    }
    
    private func sortBookReviews() {
        switch sortingOrder {
        case .ascending:
            bookReviews.sort { $0.date < $1.date }
        case .descending:
            bookReviews.sort { $0.date > $1.date }
        }
    }
}
