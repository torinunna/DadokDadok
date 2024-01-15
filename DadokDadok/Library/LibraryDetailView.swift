//
//  LibraryDetailView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import SwiftUI

struct LibraryDetailView: View {
    
    @StateObject var vm: LibraryDetailViewModel
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .center, spacing: 15) {
                fetchImage(url: vm.bookReview.book.image)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(vm.bookReview.book.title)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.vertical, 5)
                    Text(vm.bookReview.book.author)
                        .font(.system(size: 12))
                    Text(vm.bookReview.book.publisher)
                        .font(.system(size: 12))
                }
            }
            
            Text("서평 모아보기")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top)
            
            ScrollView {
                ForEach(vm.filteredReviews()) { bookReview in
                    NavigationLink {
                        let vm = ReviewDetailViewModel(bookReviews: $vm.bookReviews, bookReview: bookReview)
                        ReviewDetailView(vm: vm)
                    } label: {
                        DetailCard(bookReview: bookReview)
                    }
                    
                }
            }
        }
        .padding()
        .toolbar {
            if !vm.bookReview.book.link.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        openURL(URL(string: vm.bookReview.book.link)!)
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(width: 80, height: 100)
    }
}

