//
//  ContentView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct ContentView: View {
    let vm = ReviewListViewModel(storage: BookReviewStorage())
    
    var body: some View {
        TabView {
            NavigationStack {
                LibraryView(vm: vm)
                    .navigationTitle("나의 서재")
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("나의 서재")
            }
            
            NavigationStack {
                ReviewListView(vm: vm)
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
        ContentView()
    }
}
