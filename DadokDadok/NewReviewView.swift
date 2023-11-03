//
//  NewReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/10/01.
//

import SwiftUI

struct NewReviewView: View {
    @State private var newReview = BookReview.emptyReview
    @Binding var isPresentingNewReviewView: Bool
    @State private var isPresentingBookSearchView = false
    @Binding var reviews: [BookReview]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 20) {
                    Image(systemName: "book")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 120)
                    
                    TextField("도서명", text: $newReview.title)
                    
                    Button("검색") {
                        isPresentingBookSearchView = true
                    }
                    .frame(alignment: .trailing)
                    .sheet(isPresented: $isPresentingBookSearchView) {
                        BookSearchView()
                    }
                }
                .padding()
                
                TextEditor(text: $newReview.review)
                    .border(.gray.opacity(0.2), width: 3)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        isPresentingNewReviewView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        reviews.append(newReview)
                        isPresentingNewReviewView = false
                    }
                }
            }
        }
    }
}

struct NewReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NewReviewView(isPresentingNewReviewView: .constant(true), reviews: .constant(BookReview.sampleData))
    }
}
