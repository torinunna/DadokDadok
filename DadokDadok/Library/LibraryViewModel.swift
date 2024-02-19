//
//  LibraryViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import Foundation
import Combine

final class LibraryViewModel: ObservableObject {
    
    let storage: BookReviewStorage
    let wishStorage: WishStorage
    
    @Published var uniqueBookTitles: Set<String> = []
    @Published var bookReviews: [BookReview] = []
    @Published var wishlist: [Wish] = []
 
    init(storage: BookReviewStorage, wishStorage: WishStorage) {
        self.storage = storage
        self.wishStorage = wishStorage
        
        fetch()
        fetchWish()
    }

    func fetch() {
        self.bookReviews = storage.fetch()
        updateUniqueBook()
    }
    
    func fetchWish() {
        self.wishlist = wishStorage.fetch().sorted { $0.book.title < $1.book.title }
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
    
    private func updateUniqueBook() {
        uniqueBookTitles = Set(bookReviews.map { $0.book.isbn })
    }
}
