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
            LazyVGrid(columns: layout) {
                ForEach(vm.bookReviews) { bookReview in
                    NavigationLink {
                        let vm = LibraryDetailViewModel(bookReviews: $vm.bookReviews, bookReview: bookReview)
                        LibraryDetailView(vm: vm)
                    } label: {
                        BookCard(bookReview: bookReview)
                    }
                }
            }
        }
        .onAppear {
            vm.fetch()
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(vm: LibraryViewModel(storage: BookReviewStorage()))
    }
}
