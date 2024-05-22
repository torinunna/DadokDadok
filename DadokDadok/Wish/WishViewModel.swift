//
//  WishViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/20/24.
//

import Foundation

class WishViewModel: ObservableObject {
    let wishStorage: WishStorage
    
    @Published var wishlist: [Wish] = []
    
    init(wishStorage: WishStorage) {
        self.wishStorage = wishStorage
        
        fetch()
    }
    
    func fetch() {
        self.wishlist = wishStorage.fetch()
    }
    
    func deleteWish(offsets: IndexSet) {
        wishlist = wishStorage.delete(wishlist, atOffsets: offsets)
    }
    
    func toggleFavorite(wish: Wish) {
        if let index = wishlist.firstIndex(where: { $0.id == wish.id }) {
            wishlist[index].isFavorite.toggle()
            wishStorage.persist(wishlist)
        }
    }
}
