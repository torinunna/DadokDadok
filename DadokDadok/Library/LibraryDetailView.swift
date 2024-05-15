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
            BookCover(bookReview: vm.bookReview)
            
            Text("서평 모아보기")
                .font(.system(size: 15, weight: .medium))
                .padding(.top, 15)
                .padding(.leading, 15)
            
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
        .background(ColorManager.backgroundColor)
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
}

struct DetailCard: View {
    var bookReview: BookReview
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.cardColor.opacity(0.6))
                .frame(minHeight: 50)
            
            HStack(alignment: .center, spacing: 15) {
                Text(bookReview.date)
                    .font(.system(size: 13, weight: .medium))
                    .padding(.leading)
                
                Divider()
                    .overlay(Color.white)
                
                Text(bookReview.review)
                    .font(.system(size: 13))
                    .lineLimit(5)
                
                Spacer()
            }
            .foregroundStyle(Color.black)
            .padding(.vertical, 10)
        }
    }
}
