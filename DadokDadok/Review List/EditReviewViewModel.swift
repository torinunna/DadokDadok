//
//  EditReviewViewModel.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/21/23.
//

import Foundation

final class EditReviewViewModel: ObservableObject {
    @Published var bookReview: BookReview
    @Published var selectedDate: Date
    
    init(bookReview: BookReview) {
        self.bookReview = bookReview
        self._selectedDate = Published(initialValue: Self.dateFormatter.date(from: bookReview.date) ?? Date())
    }
    
    func saveChanges() {
        self.bookReview.date = Self.dateFormatter.string(from: selectedDate)
        
        var existingReviews = Storage.retrive("review_list.json", from: .documents, as: [BookReview].self) ?? []
        
        if let index = existingReviews.firstIndex(where: { $0.id == bookReview.id }) {
            existingReviews[index] = bookReview
        } else {
            existingReviews.append(bookReview)
        }
        
        Storage.store(existingReviews, to: .documents, as: "review_list.json")
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }()
}
