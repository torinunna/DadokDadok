//
//  ContentView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct ContentView: View {
    @Binding var reviews: [BookReview]
    
    var body: some View {
        TabView {
            NavigationStack {
                LibraryView(reviews: $reviews)
                    .navigationTitle("나의 서재")
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("나의 서재")
            }
            
            NavigationStack {
                ReviewListView(reviews: $reviews)
                    .navigationTitle("나의 서평")
            }
            .tabItem {
                Image(systemName: "book.closed")
                Text("나의 서평")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(reviews: .constant(BookReview.sampleData))
    }
}
