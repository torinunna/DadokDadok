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
        VStack(spacing: 15) {
            Image(systemName: review.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            
            Text(review.title)
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 10)
            
            Divider()
            
            Text(review.date)
                .font(.system(size: 15, weight: .medium))
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(review.review)
                        .font(.system(size: 15, weight: .regular))
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
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(review: .constant(BookReview.sampleData[0]), reviews: .constant(BookReview.sampleData))
    }
}
