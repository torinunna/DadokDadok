//
//  LibraryView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct LibraryView: View {
    
    @StateObject var vm: LibraryViewModel
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 15) {
                ForEach(vm.uniqueBookTitles.sorted(), id: \.self) { isbn in
                    if let firstReview = vm.bookReviews.first(where: { $0.isbn == isbn }) {
                        NavigationLink {
                            let vm = LibraryDetailViewModel(bookReviews: vm.bookReviews, bookReview: firstReview)
                            LibraryDetailView(vm: vm)
                        } label: {
                            BookCard(bookReview: firstReview)
                                .frame(height: 160)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }
        .padding(10)
        .onAppear {
            vm.fetch()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(vm: LibraryViewModel(storage: BookReviewStorage()))
    }
}
