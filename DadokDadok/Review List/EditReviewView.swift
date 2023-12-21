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
                fetchImage(url: vm.bookReview.imageName)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(vm.bookReview.title)
                        .font(.system(size: 14, weight: .semibold))
                    Text("\(vm.bookReview.author) | \(vm.bookReview.publisher)")
                        .font(.system(size: 13))
                    Text(vm.bookReview.isbn)
                        .font(.system(size: 12))
                }
                Spacer()
            }
            
            DatePicker("읽은 날짜", selection: $vm.selectedDate, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ko-KR"))
            
            TextEditor(text: $vm.bookReview.review)
                .border(.gray.opacity(0.2), width: 3)
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("저장") {
                    vm.saveChanges()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(width: 80, height: 100)
    }
}

struct ReviewEditView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = EditReviewViewModel(bookReview: BookReview.sampleData[0])
        EditReviewView(vm: vm)
    }
}
