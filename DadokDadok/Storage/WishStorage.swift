//
//  WishStorage.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2/4/24.
//

import Foundation

final class WishStorage {
    
    func persist(_ wishlist: [Wish]) {
        Storage.store(wishlist, to: .documents, as: "wishlist.json")
    }
    
    func fetch() -> [Wish] {
        let list = Storage.retrive("wishlist.json", from: .documents, as: [Wish].self) ?? []
        return list
    }
    
    func delete(_ wishlist: [Wish], atOffsets offsets: IndexSet) -> [Wish] {
        var updatedWishlist = wishlist
        updatedWishlist.remove(atOffsets: offsets)
        persist(updatedWishlist)
        return updatedWishlist
    }
}
