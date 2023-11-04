//
//  BookReview.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import Foundation

struct BookReview: Identifiable {
    let id: UUID = UUID()
    var imageName: String
    var title: String
    var date: String
    var review: String
    
    init(imageName: String, title: String, date: String, review: String) {
        self.imageName = imageName
        self.title = title
        self.date = date
        self.review = review
    }
    
    static var emptyReview: BookReview {
        BookReview(imageName: "", title: "", date: "", review: "")
    }
}

extension BookReview {
    static let sampleData: [BookReview] = [
        BookReview(imageName: "book", title: "code", date: "2023-04-23", review: "this is amazing"),
        BookReview(imageName: "heart", title: "heart", date: "2023-05-23", review: "I love it"),
        BookReview(imageName: "pencil", title: "pen", date: "2023-09-15", review: "I want to write")
    ]
}

