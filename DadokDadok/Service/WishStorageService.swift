//
//  WishStorageService.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/26/24.
//

import Foundation

protocol WishStorageServiceType {
    func persist(_ wishlist: [Wish])
    func fetch() -> [Wish]
}

class WishStorageService: WishStorageServiceType {
    func persist(_ wishlist: [Wish]) {
        Storage.store(wishlist, to: .documents, as: "wishlist.json")
    }
    
    func fetch() -> [Wish] {
        let list = Storage.retrive("wishlist.json", from: .documents, as: [Wish].self) ?? []
        return list
    }
}

class StubWishStorageService: WishStorageServiceType {
    func persist(_ wishlist: [Wish]) {
        
    }
    
    func fetch() -> [Wish] {
        return Wish.sampleData
    }
}
