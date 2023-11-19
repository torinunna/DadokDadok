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
    }

    func fetch() {
        self.bookReviews = storage.fetch()
    }
}
