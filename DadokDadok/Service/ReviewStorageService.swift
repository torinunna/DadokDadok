//
//  ReviewStorageService.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/26/24.
//

import Foundation

protocol ReviewStorageServiceType {
    func persist(_ bookReviews: [BookReview])
    func fetch() -> [BookReview]
}

class ReviewStorageService: ReviewStorageServiceType {
    func persist(_ bookReviews: [BookReview]) {
        Storage.store(bookReviews, to: .documents, as: "review_list.json")
    }
    
    func fetch() -> [BookReview] {
        let list = Storage.retrive("review_list.json", from: .documents, as: [BookReview].self) ?? []
        return list
    }
}
