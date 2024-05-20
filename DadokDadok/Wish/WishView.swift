//
//  WishView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/19/24.
//

import SwiftUI

struct WishView: View {
    @StateObject var vm: WishViewModel
    @State private var isPresentingNewWishView: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.wishlist.isEmpty {
                    VStack(alignment: .center, spacing: 5) {
                        Spacer()
                        Text("+ 버튼을 눌러")
                        Text("읽고 싶은 책을 추가해주세요!")
                        Spacer()
                    }
                    .font(.subheadline)
                } else {
                    List {
                        ForEach($vm.wishlist) { $wish in
                            WishCard(wish: $wish, toggleFavorite: {
                                vm.toggleFavorite(wish: wish)
                            })
                            .listRowBackground(ColorManager.backgroundColor)
                        }
                        .onDelete(perform: vm.deleteWish)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .onAppear {
                        vm.fetchWish()
                    }
                }
            }
            .navigationTitle("나의 위시")
            .toolbar {
                Button {
                    isPresentingNewWishView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewWishView) {
                let vm = NewWishViewModel(wishlist: vm.wishlist, storage: WishStorage())
                NewWishView(vm: vm, isPresentingNewWishView: $isPresentingNewWishView)
            }
        }
    }
}
