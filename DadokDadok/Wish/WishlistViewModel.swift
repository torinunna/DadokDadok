//
//  WishViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/20/24.
//

import Foundation

class WishlistViewModel: ObservableObject {
    enum Action {
        case fetch
        case delete(IndexSet)
        case toggleFavorite(Wish)
    }
    
    @Published var wishlist: [Wish] = []
    
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
 
    func send(action: Action) {
        switch action {
        case .fetch:
            wishlist = container.services.wishStorageService.fetch()
            
        case .delete(let indexSet):
            wishlist.remove(atOffsets: indexSet)
            container.services.wishStorageService.persist(wishlist)
            
        case .toggleFavorite(let wish):
            if let index = wishlist.firstIndex(where: { $0.id == wish.id }) {
                wishlist[index].isFavorite.toggle()
                container.services.wishStorageService.persist(wishlist)
            }
        }
    }
}
