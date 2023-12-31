//
//  LibraryView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct LibraryView: View {
    
    @State private var selectedView: Views = .read
    
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
                WishlistView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
                    if let firstReview = vm.bookReviews.first(where: { $0.isbn == isbn }) {
                        NavigationLink {
                            let vm = LibraryDetailViewModel(bookReviews: vm.bookReviews, bookReview: firstReview)
                            LibraryDetailView(vm: vm)
                        } label: {
                            BookCard(bookReview: firstReview)
                                .frame(height: 160)
                                .fixedSize(horizontal: false, vertical: true)
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
    var wishlist: [Wish] = Wish.sampleData
    
    var body: some View {
        
        if wishlist.isEmpty {
            VStack {
                Spacer()
                Text("읽고 싶은 책을 추가해주세요!")
                    .font(.system(.headline))
                Spacer()
            }
        } else {
            ScrollView {
                VStack {
                    ForEach(wishlist) { wish in
                        WishCard(wish: wish)
                    }
                }
            }
        }
       
    }
}
