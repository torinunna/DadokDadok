//
//  LibraryDetailView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/19.
//

import SwiftUI

struct LibraryDetailView: View {
    
    @StateObject var vm: LibraryDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 15) {
                fetchImage(url: vm.bookReview.imageName)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(vm.bookReview.title)
                        .font(.system(size: 16, weight: .bold))
                        .padding(.vertical)
                    Text(vm.bookReview.author)
                        .font(.system(size: 13))
                    Text(vm.bookReview.publisher)
                        .font(.system(size: 13))
                }
            }
            
            Text("서평 모아보기")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top)
            
            ScrollView {
                ForEach(vm.filteredReviews()) { bookReview in
                    DetailCard(bookReview: bookReview)
                }
            }
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(width: 100, height: 130)
    }
}

struct LibraryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = LibraryDetailViewModel(bookReviews: BookReview.sampleData, bookReview: BookReview.sampleData.first!)
        LibraryDetailView(vm: vm)
    }
}
