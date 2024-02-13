//
//  EditReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct EditReviewView: View {
    @ObservedObject var vm: EditReviewViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 15) {
                fetchImage(url: vm.bookReview.book.image)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(vm.bookReview.book.title)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.bottom, 3)
                    Text("\(vm.bookReview.book.author) | \(vm.bookReview.book.publisher)")
                        .font(.system(size: 13))
                    Text(vm.bookReview.book.isbn)
                        .font(.system(size: 12))
                }
            }
            
            DatePicker("읽은 날짜", selection: $vm.selectedDate, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ko-KR"))
            
            TextEditor(text: $vm.bookReview.review)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black.opacity(0.25), lineWidth: 1)
                )
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("저장") {
                    vm.saveChanges()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled( vm.bookReview.review.isEmpty)
            }
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
        .frame(width: 80, height: 100)
    }
}


struct EditReviewView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = EditReviewViewModel(bookReview:  BookReview.sampleData.first!)
        EditReviewView(vm: vm)
    }
}
