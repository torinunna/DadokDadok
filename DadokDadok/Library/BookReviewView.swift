//
//  BookReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct BookReviewView: View {
    @ObservedObject var vm: BookReviewViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            BookCover(bookReview: vm.bookReview)
            
            Divider()
                .padding(5)
            
            HStack {
                Spacer()
                Text("읽은 날짜 : \(vm.bookReview.date)")
                    .font(.footnote)
                    .fontWeight(.medium)
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(ColorManager.cardColor.opacity(0.6))
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
                        .background(ColorManager.redColor)
                        .cornerRadius(10)
                }
                Spacer()
                
                NavigationLink(destination: EditReviewView(vm: EditReviewViewModel(bookReview: vm.bookReview))) {
                    Text("수정하기")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.white)
                        .background(ColorManager.accentColor)
                        .cornerRadius(10)
                }
                Spacer()
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
        .onAppear {
            vm.fetch()
        }
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = BookReviewViewModel(bookReviews: .constant(BookReview.sampleData), bookReview: BookReview.sampleData.first!)
        BookReviewView(vm: vm)
    }
}
