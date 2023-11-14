//
//  ReviewDetailView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct ReviewDetailView: View {
    @Binding var review: BookReview
    @Binding var reviews: [BookReview]
    @Environment(\.presentationMode) var presentationMode
    
    @State var editingReview = BookReview.emptyReview
    @State private var isPresentingEditView = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            fetchImage(url: review.imageName)
            
            Text(review.title)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 15)
            
            Text(review.author)
                .font(.system(size: 13, weight: .medium))
                .padding(.top, 6)
            Text(review.publisher)
                .font(.system(size: 13, weight: .medium))
            
            Divider()
                .padding(.vertical, 10)
            
            Text(review.date)
                .font(.system(size: 13, weight: .medium))
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(review.review)
                        .font(.system(size: 13))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            
            HStack {
                Spacer()
                
                Button {
                    deleteReview()
                } label: {
                    Text("삭제하기")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button {
                    isPresentingEditView = true
                    editingReview = review
                } label: {
                    Text("수정하기")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isPresentingEditView) {
                    NavigationStack {
                        ReviewEditView(review: $editingReview)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("취소") {
                                        isPresentingEditView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("저장") {
                                        isPresentingEditView = false
                                        review = editingReview
                                    }
                                }
                            }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func deleteReview() {
        $reviews.wrappedValue = $reviews.wrappedValue.filter { $0.id != review.id }
        presentationMode.wrappedValue.dismiss()
        print(reviews)
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(width: 100, height: 120)
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(review: .constant(BookReview.sampleData[0]), reviews: .constant(BookReview.sampleData))
    }
}
