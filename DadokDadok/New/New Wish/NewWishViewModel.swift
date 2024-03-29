//
//  NewWishViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2/28/24.
//

import Combine
import SwiftUI

enum Views {
    case searchBookView
    case userInputView
}

final class NewWishViewModel: ObservableObject {
    @Published var wish: Wish = Wish.emptyWish
    @Published var wishlist: [Wish]
    @Published var selectedView: Views = .searchBookView
    @Published var book: Book = Book(title: "", image: "", author: "", publisher: "", isbn: "", link: "")
    @Published var selectedBook: Book?
    
    var subscriptions = Set<AnyCancellable>()
    
    let storage: WishStorage
    
    init(wishlist: [Wish], storage: WishStorage) {
        self.wishlist = wishlist
        self.storage = storage
        
        $wishlist.sink { wishlist in
            self.persist(wishlist: wishlist)
        }.store(in: &subscriptions)
        
        $book.sink { book in
            self.update(book: book)
        }.store(in: &subscriptions)
    }
    
    func update(book: Book) {
        self.wish.book = book
    }

    func persist(wishlist: [Wish]) {
        guard wishlist.isEmpty == false else { return }
        self.storage.persist(wishlist)
    }
    
    func completed() {
        wishlist.append(wish)
        print(wish)
    }
}
