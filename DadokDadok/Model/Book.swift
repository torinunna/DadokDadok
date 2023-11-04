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
    let title: String
    let image: String
    let author: String
    let publisher: String
}
