//
//  ReviewListViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/15.
//

import Foundation
import Combine

enum SortingOrder {
    case ascending, descending
}

final class ReviewListViewModel: ObservableObject {
    
    let storage: BookReviewStorage
    
    @Published var bookReviews: [BookReview] = []
    @Published var sortingOrder: SortingOrder = .descending
    
    var subscriptions = Set<AnyCancellable>()
    
    init(storage: BookReviewStorage) {
        self.storage = storage
        bind()
    }
    
    private func bind() {
        $bookReviews.sink { bookReviews in
            self.persist(bookReviews: bookReviews)
        }.store(in: &subscriptions)
    }
    
    func persist(bookReviews: [BookReview]) {
        guard bookReviews.isEmpty == false else { return }
        self.storage.persist(bookReviews)
    }
    
    func fetch() {
        self.bookReviews = storage.fetch()
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
