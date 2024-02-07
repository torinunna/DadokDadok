//
//  BookReviewStorage.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/15.
//

import Foundation

final class BookReviewStorage {
    
    func persist(_ bookReviews: [BookReview]) {
        Storage.store(bookReviews, to: .documents, as: "review_list.json")
    }
    
    func fetch() -> [BookReview] {
        let list = Storage.retrive("review_list.json", from: .documents, as: [BookReview].self) ?? []
        return list
    }
    
    func delete(_ bookReviews: [BookReview], atOffsets offsets: IndexSet) -> [BookReview] {
        var updatedBookReviews = bookReviews
        updatedBookReviews.remove(atOffsets: offsets)
        persist(updatedBookReviews)
        return updatedBookReviews
    }
}
