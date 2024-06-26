//
//  LibraryViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import Foundation
import Combine

final class LibraryViewModel: ObservableObject {
    enum Action {
        case fetch
    }
    
    @Published var bookReviews: [BookReview] = []
    @Published var searchQuery: String = ""
    
    private var container: DIContainer
 
    init(container: DIContainer) {
        self.container = container
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
    
    var searchedResult: [BookReview] {
        uniqueBookReviews.filter {
            $0.book.title.localizedCaseInsensitiveContains(searchQuery) ||
            $0.book.author.localizedCaseInsensitiveContains(searchQuery) ||
            $0.book.publisher.localizedCaseInsensitiveContains(searchQuery)
        }
    }
    
    func send(action: Action) {
        switch action {
        case .fetch:
            bookReviews = container.services.reviewStorageService.fetch().sorted { $0.date > $1.date }
        }
    }
}
