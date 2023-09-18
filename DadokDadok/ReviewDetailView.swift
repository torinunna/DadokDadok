//
//  ReviewDetailView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct ReviewDetailView: View {
    @Binding var review: BookReview
    
    @State var editingReview = BookReview.emptyReview
    @State private var isPresentingEditView = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text(review.title)
                .font(.system(size: 30, weight: .bold))
                .padding(.bottom, 30)
            
            Image(systemName: review.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            
            Spacer()
            
            Divider()
            
            Spacer()
            
            Text(review.date)
                .font(.system(size: 13, weight: .semibold))
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(review.review)
                        .font(.system(size: 16, weight: .medium))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    
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
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(review: .constant(BookReview.sampleData[0]))
    }
}
