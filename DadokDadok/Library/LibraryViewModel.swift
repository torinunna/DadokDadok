//
//  LibraryViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import Foundation
import Combine

final class LibraryViewModel: ObservableObject {
    
    let storage: BookReviewStorage
    
    @Published var bookReviews: [BookReview] = []
 
    init(storage: BookReviewStorage) {
        self.storage = storage
        fetch()
    }
    
    var uniqueBookReviews: [BookReview] {
        var uniqueBooks = Set<String>()
        return bookReviews.filter { review in
            let identifier = review.book.isbn.isEmpty ? review.book.title : review.book.isbn
            
            if uniqueBooks.contains(identifier) {
                return false
            } else {
                uniqueBooks.insert(identifier)
                return true
            }
        }
    }

    func fetch() {
        self.bookReviews = storage.fetch()
    }
}
