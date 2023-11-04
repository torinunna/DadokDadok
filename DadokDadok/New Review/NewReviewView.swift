//
//  NewReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/10/01.
//

import SwiftUI

struct NewReviewView: View {
    @StateObject var vm: ReviewViewModel
    @Binding var isPresentingNewReviewView: Bool
    @State private var isPresentingBookSearchView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack(spacing: 20) {
                    Image(systemName: "book")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 100)
                    
                    TextField("도서명", text: $vm.title)
                    
                    Button("검색") {
                        isPresentingBookSearchView = true
                    }
                    .frame(alignment: .trailing)
                    .sheet(isPresented: $isPresentingBookSearchView) {
                        BookSearchView()
                    }
                }
                .padding(.horizontal)
                
                DatePicker("읽은 날짜", selection: $vm.date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .environment(\.locale, Locale.init(identifier: "ko-KR"))
                    .padding(.horizontal)
                
                TextEditor(text: $vm.review)
                    .border(.gray.opacity(0.2), width: 3)
            }
            .padding(.horizontal)
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        isPresentingNewReviewView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        vm.completed()
                        isPresentingNewReviewView = false
                    }
                }
            }
        }
    }
}

struct NewReviewView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ReviewViewModel(reviewList: .constant(BookReview.sampleData))
        NewReviewView(vm: vm, isPresentingNewReviewView: .constant(true))
    }
}
