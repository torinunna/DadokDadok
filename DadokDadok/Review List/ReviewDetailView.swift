//
//  ReviewDetailView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct ReviewDetailView: View {
    
    @StateObject var vm: ReviewDetailViewModel
    
    @State var editingReview = BookReview.emptyReview
    @State private var isPresentingEditView = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            fetchImage(url: vm.bookReview.imageName)
            
            Text(vm.bookReview.title)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 15)
            
            Text(vm.bookReview.author)
                .font(.system(size: 13, weight: .medium))
                .padding(.top, 6)
            Text(vm.bookReview.publisher)
                .font(.system(size: 13, weight: .medium))
            
            Divider()
                .padding(.vertical, 10)
            
            Text(vm.bookReview.date)
                .font(.system(size: 13, weight: .medium))
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(vm.bookReview.review)
                        .font(.system(size: 13))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            
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
                
                Button {
                    isPresentingEditView = true
                    editingReview = vm.bookReview
                } label: {
                    Text("수정하기")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isPresentingEditView) {
                    NavigationStack {
                        ReviewEditView(bookReview: $editingReview)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("취소") {
                                        isPresentingEditView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("저장") {
                                        isPresentingEditView = false
                                        vm.bookReview = editingReview
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
        let vm = ReviewDetailViewModel(bookReviews: .constant(BookReview.sampleData), bookReview: BookReview.sampleData.first!)
        ReviewDetailView(vm: vm)
    }
}
