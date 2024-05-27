//
//  MainTabView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/21/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        TabView {
            LibraryView(vm: .init(container: container))
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("나의 서재")
                }
            
            WishlistView(vm: .init(container: container))
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
