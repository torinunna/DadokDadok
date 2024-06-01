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
    @Environment(\.dismiss) private var dismiss
    @State private var selectedReview: BookReview?
    @State private var isPresentingBookReviewView = false
    @State private var isPresentingNewReviewView = false
    @Binding var selectedBook: Book?

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            BookCover(bookReview: vm.bookReview)
            
            Divider()
                .padding(.vertical, 5)
            
            HStack(alignment: .center) {
                Text("나의 서평")
                    .font(.system(size: 15, weight: .medium))
                
                Spacer()
                
                Button {
                    vm.sortOrder()
                } label: {
                    Image(systemName: "arrow.up.arrow.down.circle")
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                ForEach(vm.filteredReviews) { bookReview in
                    DetailCard(bookReview: bookReview)
                        .onTapGesture {
                            selectedReview = bookReview
                            isPresentingBookReviewView = true
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
                    selectedBook = vm.bookReview.book
                    isPresentingNewReviewView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingBookReviewView) {
            if let selectedReview = selectedReview {
                let vm = BookReviewViewModel(bookReviews: $vm.bookReviews, bookReview: selectedReview)
                BookReviewView(vm: vm)
            }
        }
        .sheet(isPresented: $isPresentingNewReviewView) {
            NewReviewView(vm: .init(bookReviews: $vm.bookReviews, container: container), isPresentingNewReviewView: $isPresentingNewReviewView, selectedBook: $selectedBook)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: vm.filteredReviewsCount) { newCount in
            if newCount == 0 {
                dismiss()
            }
        }
        .onAppear {
            if vm.filteredReviewsCount == 0 {
                dismiss()
            }
        }
    }
}

struct DetailCard: View {
    var bookReview: BookReview
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorManager.cardColor.opacity(0.6))
                .frame(minHeight: 50)
            
            HStack(alignment: .center, spacing: 15) {
                Text(Self.dateFormatter.string(from: bookReview.date))
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
