//
//  LibraryDetailViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import Foundation
import SwiftUI

final class LibraryDetailViewModel: ObservableObject {
    
    @Published var bookReviews: [BookReview] = []
    @Published var bookReview: BookReview
    
    init(bookReviews: [BookReview], bookReview: BookReview) {
        self.bookReviews = bookReviews
        self.bookReview = bookReview
    }
    
    func filteredReviews() -> [BookReview] {
        return bookReviews
            .filter { $0.book.isbn == bookReview.book.isbn }
            .sorted { $0.date < $1.date }
    }
}
