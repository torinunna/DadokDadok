//
//  ReviewListView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

struct ReviewListView: View {
    @StateObject var vm: ReviewListViewModel
    @State private var isPresentingNewReviewView = false
    
    var body: some View {
        List(vm.list) { bookReview in
            NavigationLink {
                let vm = ReviewDetailViewModel(reviewList: $vm.list, bookReview: bookReview)
                ReviewDetailView(vm: vm)
            } label: {
                ReviewCard(bookReview: bookReview)
            }
        }
        
        .toolbar {
            Button(action: {
                isPresentingNewReviewView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewReviewView) {
            let vm = NewReviewViewModel(reviewList: $vm.list)
            NewReviewView(vm: vm, isPresentingNewReviewView: $isPresentingNewReviewView)
        }
        .onAppear {
            vm.fetch()
        }
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView(vm: ReviewListViewModel(storage: BookReviewStorage()))
    }
}
