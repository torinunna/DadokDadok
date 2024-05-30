//
//  BookReview.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import Foundation

struct BookReview: Identifiable, Codable {
    var id: UUID = UUID()
    var book: Book
    var date: Date
    var review: String
    
    init(book: Book, date: Date, review: String) {
        self.book = book
        self.date = date
        self.review = review
    }
    
    static var emptyReview: BookReview {
        BookReview(book: Book(title: "", image: "", author: "", publisher: "", isbn: "", link: ""), date: Date(), review: "")
    }
}

extension BookReview {
    static let sampleData: [BookReview] = [
        BookReview(book: Book(title: "book1", image: "book", author: "who1", publisher: "pub1", isbn: "2423236", link: "sadfasd.asdf"), date: Date(), review: "this is amazing"),
        BookReview(book: Book(title: "book2", image: "heart", author: "who2", publisher: "pub2", isbn: "2423236", link: "sadfasd.asdf"), date: Date(), review: "I love it"),
        BookReview(book: Book(title: "book3", image: "pencil", author: "who3", publisher: "pub3", isbn: "2423236", link: "sadfasd.asdf"), date: Date(), review: "I want to write")
    ]
}

