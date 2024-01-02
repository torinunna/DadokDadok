//
//  Wish.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/31/23.
//

import Foundation

struct Wish: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let imageName: String
    let author: String
    let publisher: String
    let isbn: String
    let link: String
    
    init(title: String, imageName: String, author: String, publisher: String, isbn: String, link: String) {
        self.title = title
        self.imageName = imageName
        self.author = author
        self.publisher = publisher
        self.isbn = isbn
        self.link = link
    }
    
    static var emptyWish: Wish {
        Wish(title: "", imageName: "", author: "", publisher: "", isbn: "", link: "")
    }
}

extension Wish {
    static let sampleData: [Wish] = [
        Wish(title: "titletitletitletitletitletitletitletitle", imageName: "book", author: "author", publisher: "any", isbn: "548654365", link: "ㄴㅇㄱ"),
        Wish(title: "title2", imageName: "heart", author: "author2", publisher: "any", isbn: "548654365", link: "ㄴㅇㄱ"),
        Wish(title: "title3", imageName: "pen", author: "author3", publisher: "any", isbn: "548654365", link: "ㄴㅇㄱ")
    ]
}
