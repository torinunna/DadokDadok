//
//  NewReviewViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/04.
//

import SwiftUI
import Combine

final class NewReviewViewModel: ObservableObject {
    @Published var bookReviews: Binding<[BookReview]>
    @Published var bookReview: BookReview = BookReview.emptyReview
    @Published var book: Book = Book(title: "", image: "", author: "", publisher: "", isbn: "", link: "")
    @Published var date: Date = Date()
    @Published var review: String = ""
    @Published var selectedView: Views = .searchBookView
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(bookReviews: Binding<[BookReview]>, container: DIContainer) {
        self.bookReviews = bookReviews
        self.container = container
        
        $book.sink { book in
            self.update(book: book)
        }.store(in: &subscriptions)
       
        $date.sink { date in
            self.update(date: date)
        }.store(in: &subscriptions)
        
        $review.sink { review in
            self.update(review: review)
        }.store(in: &subscriptions)
    }
    
    func update(book: Book) {
        self.bookReview.book = book
    }
    
    func update(date: Date) {
        self.bookReview.date = date
    }
    
    func update(review: String) {
        self.bookReview.review = review
    }
    
    func completed() {
        bookReviews.wrappedValue.append(bookReview)
        container.services.reviewStorageService.persist(bookReviews.wrappedValue)
        print(bookReview)
    }
}
