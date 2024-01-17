//
//  Book.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/02.
//

import Foundation

struct BookList: Codable {
    let total: Int
    let start: Int
    let display: Int
    let items: [Book]
}

struct Book: Codable, Hashable {
    var title: String
    var image: String
    var author: String
    var publisher: String
    var isbn: String
    var link: String
}
