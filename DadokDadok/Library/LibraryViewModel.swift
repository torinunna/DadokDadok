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
    
    @Published var uniqueBookTitles: Set<String> = []
    @Published var bookReviews: [BookReview] = []
 
    init(storage: BookReviewStorage) {
        self.storage = storage
    }

    func fetch() {
        self.bookReviews = storage.fetch()
        updateUniqueBookTitles()
    }
    
    private func updateUniqueBookTitles() {
        uniqueBookTitles = Set(bookReviews.map { $0.title })
    }
}
