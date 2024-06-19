//
//  NewWishViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2/28/24.
//

import Combine
import SwiftUI

final class NewWishViewModel: ObservableObject {
    @Published var wishlist: Binding<[Wish]>
    @Published var wish: Wish = Wish.emptyWish
    @Published var selectedView: Views = .searchBookView
    @Published var book: Book = Book(title: "", image: "", author: "", publisher: "", isbn: "", link: "")
    @Published var selectedBook: Book?
    @Published var isPresented: Binding<Bool>
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(wishlist: Binding<[Wish]>, container: DIContainer, isPresented: Binding<Bool>) {
        self.wishlist = wishlist
        self.container = container
        self.isPresented = isPresented
        
        $book.sink { book in
            self.update(book: book)
        }.store(in: &subscriptions)
    }
    
    func update(book: Book) {
        self.wish.book = book
    }

    func completed() {
        wishlist.wrappedValue.append(wish)
        container.services.wishStorageService.persist(wishlist.wrappedValue)
        isPresented.wrappedValue = false
        print(wish)
    }
}
