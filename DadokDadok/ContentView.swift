//
//  ContentView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationStack {
                LibraryView(vm: LibraryViewModel(storage: BookReviewStorage()))
                    .navigationTitle("나의 서재")
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("나의 서재")
            }
            
            NavigationStack {
               WishView(vm: WishViewModel(wishStorage: WishStorage()))
                    .navigationTitle("나의 위시")
            }
            .tabItem {
                Image(systemName: "heart")
                Text("나의 위시")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
