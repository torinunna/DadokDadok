//
//  LibraryDetailViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import Foundation
import SwiftUI

final class LibraryDetailViewModel: ObservableObject {
    
    @Published var bookReviews: Binding<[BookReview]>
    @Published var bookReview: BookReview
    
    init(bookReviews: Binding<[BookReview]>, bookReview: BookReview) {
        self.bookReviews = bookReviews
        self.bookReview = bookReview
    }
    
    func delete() {
        bookReviews.wrappedValue = bookReviews.wrappedValue.filter { $0.id != bookReview.id }
    }
    
}
