//
//  WishView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/19/24.
//

import SwiftUI

struct WishView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var vm: WishViewModel
    @State private var isPresentingNewWishView: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                VStack {
                    if vm.wishlist.isEmpty {
                        Spacer()
                        Text("+ 버튼을 눌러")
                        Text("읽고 싶은 책을 추가해주세요!")
                        Spacer()
                    } else {
                        List {
                            ForEach(vm.wishlist) { wish in
                                WishCard(wish: wish)
                                    .environmentObject(vm)
                                    .listRowSeparator(.hidden)
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
            .onAppear {
                vm.send(action: .fetch)
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
                NewWishView(vm: .init(wishlist: $vm.wishlist, container: container), isPresentingNewWishView: $isPresentingNewWishView)
            }
        }
    }
}
