//
//  BookReview.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import Foundation

struct BookReview: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var imageName: String
    var author: String
    var publisher: String
    var isbn: String
    var date: String
    var review: String
    
    init(title: String, imageName: String, author: String, publisher: String, isbn: String, date: String, review: String) {
        self.title = title
        self.imageName = imageName
        self.author = author
        self.publisher = publisher
        self.isbn = isbn
        self.date = date
        self.review = review
    }
    
    static var emptyReview: BookReview {
        BookReview(title: "", imageName: "", author: "", publisher: "", isbn: "", date: "", review: "")
    }
}

extension BookReview {
    static let sampleData: [BookReview] = [
        BookReview(title: "code", imageName: "book", author: "who", publisher: "any", isbn: "548654365", date: "2023-04-23", review: "this is amazing"),
        BookReview(title: "heart", imageName: "heart", author: "who", publisher: "any", isbn: "345627534", date: "2023-05-23", review: "I love it"),
        BookReview(title: "pen", imageName: "pencil", author: "who", publisher: "any", isbn: "3423463457", date: "2023-09-15", review: "I want to write")
    ]
}

