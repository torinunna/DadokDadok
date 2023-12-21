//
//  ReviewDetailView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct ReviewDetailView: View {
    
    @ObservedObject var vm: ReviewDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack(spacing: 15) {
                fetchImage(url: vm.bookReview.imageName)
                VStack(alignment: .leading, spacing: 3) {
                    Text(vm.bookReview.title)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.bottom, 5)
                    Text(vm.bookReview.author)
                        .font(.system(size: 12))
                    Text(vm.bookReview.publisher)
                        .font(.system(size: 12))
                    Text(vm.bookReview.isbn)
                        .font(.system(size: 12))
                }
                Spacer()
            }
            
            Divider()
                .padding(5)
            
            Text(vm.bookReview.date)
                .font(.system(size: 14, weight: .medium))
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.yellow)
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(vm.bookReview.review)
                            .font(.system(size: 15))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            
            HStack {
                Spacer()
                Button {
                    vm.delete()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("삭제하기")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                Spacer()
                
                NavigationLink(destination: EditReviewView(vm: EditReviewViewModel(bookReview: vm.bookReview))) {
                    Text("수정하기")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding(.vertical)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.fetch()
        }
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(width: 90, height: 120)
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ReviewDetailViewModel(bookReviews: .constant(BookReview.sampleData), bookReview: BookReview.sampleData.first!)
        ReviewDetailView(vm: vm)
    }
}
