//
//  LibraryView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct LibraryView: View {
    
    @State private var selectedView: Views = .read
    @State private var isPresentingNewWishView = false
    @State private var wishlist: [Wish] = []
    
    enum Views {
        case read
        case wishlist
    }
    
    var body: some View {
        VStack {
            Picker("Select View", selection: $selectedView) {
                Text("읽은 책").tag(Views.read)
                Text("읽고 싶은 책").tag(Views.wishlist)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.top)
            
            if selectedView == .read {
                ReadBooksView(vm: LibraryViewModel(storage: BookReviewStorage()))
            } else {
                WishlistView(wishlist: $wishlist)
                    .toolbar {
                        Button {
                            isPresentingNewWishView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
            }
        }
        .background(ColorManager.backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresentingNewWishView) {
         NewWishView(isPresentingNewWishView: $isPresentingNewWishView, wishList: $wishlist)
        }
    }
}

// MARK: - Read Books View

struct ReadBooksView : View {
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @StateObject var vm: LibraryViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 15) {
                ForEach(vm.uniqueBookTitles.sorted(), id: \.self) { isbn in
                    if let firstReview = vm.bookReviews.first(where: { $0.book.isbn == isbn }) {
                        NavigationLink {
                            let vm = LibraryDetailViewModel(bookReviews: vm.bookReviews, bookReview: firstReview)
                            LibraryDetailView(vm: vm)
                        } label: {
                            BookCard(bookReview: firstReview)
                        }
                    }
                }
            }
        }
        .padding(10)
        .onAppear {
            vm.fetch()
        }
    }
}

// MARK: - Wishlist View

struct WishlistView: View {
    @Binding var wishlist: [Wish]
    
    var body: some View {
        
        if wishlist.isEmpty {
            VStack(alignment: .center, spacing: 5) {
                Spacer()
                Text("+ 버튼을 눌러")
                Text("읽고 싶은 책을 추가해주세요!")
                Spacer()
            }
            .font(.subheadline)
        } else {
            ScrollView {
                ForEach($wishlist) { wish in
                    WishCard(wish: wish)
                }
            }
            .padding(.vertical)
        }
    }
}
