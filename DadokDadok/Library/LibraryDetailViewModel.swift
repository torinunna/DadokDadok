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
    
    init(bookReviews: [BookReview], bookReview: BookReview) {
        self.bookReviews = bookReviews
        self.bookReview = bookReview
    }
    
    func filteredReviews() -> [BookReview] {
        let identifier = bookReview.book.isbn.isEmpty ? bookReview.book.title : bookReview.book.isbn
        return bookReviews.filter { review in
            let reviewIdentifier = review.book.isbn.isEmpty ? review.book.title : review.book.isbn
            return reviewIdentifier == identifier
        }
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
