//
//  Wish.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/31/23.
//

import Foundation

struct Wish: Identifiable, Codable {
    var id: UUID = UUID()
    var book: Book
    var isFavorite: Bool = false
    
    init(book: Book, isFavorite: Bool = false) {
        self.book = book
        self.isFavorite = isFavorite
    }
    
    static var emptyWish: Wish {
        Wish(book: Book(title: "", image: "", author: "", publisher: "", isbn: "", link: ""), isFavorite: false)
    }
}

extension Wish {
    static let sampleData: [Wish] = [
        Wish(book: Book(title: "book1", image: "book", author: "who1", publisher: "pub1", isbn: "12431236", link: "aaa.aaa"), isFavorite: false),
        Wish(book: Book(title: "book2", image: "heart", author: "who2", publisher: "pub2", isbn: "4358798", link: "bbb.aaa"), isFavorite: false),
        Wish(book: Book(title: "book3", image: "pen", author: "who3", publisher: "pub3", isbn: "12456346", link: "ccc.aaa"), isFavorite: true)
    ]
}
