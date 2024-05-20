//
//  MainTabView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/21/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            LibraryView(vm: LibraryViewModel(storage: BookReviewStorage()))
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("나의 서재")
                }
            
            WishView(vm: WishViewModel(wishStorage: WishStorage()))
                .tabItem {
                    Image(systemName: "heart")
                    Text("나의 위시")
                }
        }
    }
}

#Preview {
    MainTabView()
}
