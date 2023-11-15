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
    
    @Published var list: [BookReview] = []
    
    var subscriptions = Set<AnyCancellable>()
    
    init(storage: BookReviewStorage) {
        self.storage = storage
        bind()
    }
    
    private func bind() {
        $list.sink { reviews in
            self.persist(reviews: reviews)
        }.store(in: &subscriptions)
    }
    
    func persist(reviews: [BookReview]) {
        guard reviews.isEmpty == false else { return }
        self.storage.persist(reviews)
    }
    
    func fetch() {
        self.list = storage.fetch()
    }
}
