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
    @Published var title: String = ""
    @Published var imageName: String = ""
    @Published var author: String = ""
    @Published var publisher: String = ""
    @Published var date: Date = Date()
    @Published var review: String = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    init(bookReviews: Binding<[BookReview]>) {
        self.bookReviews = bookReviews
        
        $title.sink { title in
            self.update(title: title)
        }.store(in: &subscriptions)
       
        $imageName.sink { imageName in
            self.update(imageName: imageName)
        }.store(in: &subscriptions)
        
        $author.sink { author in
            self.update(author: author)
        }.store(in: &subscriptions)
        
        $publisher.sink { publisher in
            self.update(publisher: publisher)
        }.store(in: &subscriptions)
        
        $date.sink { date in
            self.update(date: date)
        }.store(in: &subscriptions)
        
        $review.sink { review in
            self.update(review: review)
        }.store(in: &subscriptions)
    }
    
    func update(title: String) {
        self.bookReview.title = title
    }
    
    func update(imageName: String) {
        self.bookReview.imageName = imageName
    }
    
    func update(author: String) {
        self.bookReview.author = author
    }
    
    func update(publisher: String) {
        self.bookReview.publisher = publisher
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
