//
//  LibraryView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct LibraryView: View {
    
    @StateObject var vm: ReviewListViewModel
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(vm.list) { review in
                    BookView(bookReview: review)
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
        LibraryView(vm: ReviewListViewModel(storage: BookReviewStorage()))
    }
}
