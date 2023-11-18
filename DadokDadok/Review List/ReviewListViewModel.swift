//
//  ReviewListViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/15.
//

import Foundation
import Combine

final class ReviewListViewModel: ObservableObject {
    
    let storage: BookReviewStorage
    
    @Published var bookReviews: [BookReview] = []
    
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
}
