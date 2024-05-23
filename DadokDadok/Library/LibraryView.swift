//
//  LibraryView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct LibraryView: View {
    
    @StateObject var vm: LibraryViewModel
    @State private var isPresentingNewReviewView = false
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            booksReadView
                .toolbar {
                    Button {
                        isPresentingNewReviewView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .background(ColorManager.backgroundColor)
                .onAppear {
                    vm.fetch()
                }
                .sheet(isPresented: $isPresentingNewReviewView) {
                    let vm = NewReviewViewModel(bookReviews: vm.bookReviews, storage: BookReviewStorage())
                    NewReviewView(vm: vm, isPresentingNewReviewView: $isPresentingNewReviewView)
                }
                .navigationTitle("나의 서재")
        }
    }
    
    var booksReadView: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 15) {
//                ForEach(vm.uniqueBookTitles.sorted(), id: \.self) { isbn in
                ForEach(vm.bookReviews) {  book in
//                    if let firstReview = vm.bookReviews.first(where: { $0.book.isbn == isbn }) {
                        NavigationLink {
                            let vm = LibraryDetailViewModel(bookReviews: vm.bookReviews, bookReview: book)
                            LibraryDetailView(vm: vm)
                        } label: {
                            BookCard(bookReview: book)
                        }
//                    }
                }
            }
        }
        .padding(10)
    }
}
