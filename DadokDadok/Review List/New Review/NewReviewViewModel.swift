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
    
    var subscriptions = Set<AnyCancellable>()
    
    init(bookReviews: Binding<[BookReview]>) {
        self.bookReviews = bookReviews
        
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        self.bookReview.date = formatter.string(from: date)
    }
    
    func update(review: String) {
        self.bookReview.review = review
    }
    
    func completed() {
        guard bookReview.date.isEmpty == false else { return }
        bookReviews.wrappedValue.append(bookReview)
        print(bookReview)
    }
}
