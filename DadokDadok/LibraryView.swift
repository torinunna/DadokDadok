//
//  LibraryView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct LibraryView: View {
    @Binding var reviews: [BookReview]
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach($reviews) { $review in
                    BookView(review: review)
                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(reviews: .constant(BookReview.sampleData))
    }
}
