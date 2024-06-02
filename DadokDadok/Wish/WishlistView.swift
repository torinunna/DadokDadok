//
//  WishlistView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/19/24.
//

import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var vm: WishlistViewModel
    @State private var isPresentingNewWishView = false
    @State private var showFavoritesOnly = false
    
    var filteredWishlist: [Wish] {
        return showFavoritesOnly ? vm.wishlist.filter { $0.isFavorite } : vm.wishlist
    }
    
    var body: some View {
        NavigationStack {
            Group {
                VStack(alignment: .center) {
                    if vm.wishlist.isEmpty {
                        Spacer()
                        Text("+ 버튼을 눌러\n읽고 싶은 책을 추가해주세요!")
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .tracking(1.5)
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredWishlist) { wish in
                                WishCard(wish: wish)
                                    .environmentObject(vm)
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                            }
                            .onDelete { indexSet in
                                vm.send(action: .delete(indexSet))
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .font(.system(size: 14))
            }
            .frame(maxWidth: .infinity)
            .background(ColorManager.backgroundColor)
            .onAppear {
                vm.send(action: .fetch)
            }
            .navigationTitle("나의 위시")
            .toolbar {
                if !vm.wishlist.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showFavoritesOnly.toggle()
                        } label: {
                            showFavoritesOnly ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingNewWishView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewWishView) {
                NewWishView(vm: .init(wishlist: $vm.wishlist, container: container), isPresentingNewWishView: $isPresentingNewWishView)
            }
        }
    }
}
