//
//  LibraryDetailView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import SwiftUI

struct LibraryDetailView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var vm: LibraryDetailViewModel
    @Environment(\.openURL) private var openURL
    @State private var isPresentingDetailView = false
    @State private var isPresentingNewReviewView = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            BookCover(bookReview: vm.bookReview)
            
            Divider()
                .padding(.vertical, 5)
            
            HStack(alignment: .center) {
                Text("나의 서평")
                    .font(.system(size: 15, weight: .medium))
                
                Spacer()
                
                Button(action: vm.sortOrder) {
                    Image(systemName: "arrow.up.arrow.down.circle")
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                ForEach(vm.filteredReviews()) { bookReview in
                    DetailCard(bookReview: bookReview)
                        .onTapGesture {
                            isPresentingDetailView = true
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isPresentingNewReviewView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingDetailView) {
            let vm = BookReviewViewModel(bookReviews: $vm.bookReviews, bookReview: vm.bookReview)
            BookReviewView(vm: vm)
        }
        .sheet(isPresented: $isPresentingNewReviewView) {
            NewReviewView(vm: .init(bookReviews: $vm.bookReviews, container: container), isPresentingNewReviewView: $isPresentingNewReviewView)
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
