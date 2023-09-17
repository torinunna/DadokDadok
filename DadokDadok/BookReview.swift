//
//  BookReview.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import Foundation

struct BookReview: Identifiable {
    let id: UUID = UUID()
    var title: String
    var imageName: String
    var date: String
    var review: String
}

extension BookReview {
    static let sampleData: [BookReview] = [
        BookReview(title: "code", imageName: "book", date: "2023-04-23", review: "this is amazing"),
        BookReview(title: "heart", imageName: "heart", date: "2023-05-23", review: "I love it"),
        BookReview(title: "pen", imageName: "pencil", date: "2023-09-15", review: "I want to write")
    ]
}

