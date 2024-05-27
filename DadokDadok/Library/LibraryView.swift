//
//  LibraryView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var container: DIContainer
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
                    vm.send(action: .fetch)
                }
                .sheet(isPresented: $isPresentingNewReviewView) {
                    NewReviewView(vm: .init(bookReviews: $vm.bookReviews, container: container), isPresentingNewReviewView: $isPresentingNewReviewView)
                }
                .navigationTitle("나의 서재")
        }
    }
    
    var booksReadView: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 15) {
                ForEach(vm.uniqueBookReviews) { bookReview in
                    NavigationLink {
                        LibraryDetailView(vm: .init(bookReviews: vm.bookReviews, bookReview: bookReview, container: container))
                    } label: {
                        BookCard(bookReview: bookReview)
                    }
                }
            }
        }
        .padding(10)
    }
}
