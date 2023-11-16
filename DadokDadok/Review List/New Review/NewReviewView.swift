//
//  NewReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/10/01.
//

import SwiftUI

struct NewReviewView: View {
    @StateObject var vm: NewReviewViewModel
    @Binding var isPresentingNewReviewView: Bool
    @State private var isPresentingBookSearchView = false
    @State private var selectedBook: Book?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack(spacing: 20) {
                    if let selectedBook = selectedBook {
                        
                        fetchImage(url: selectedBook.image)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(selectedBook.title)
                                .font(.system(size: 14, weight: .semibold))
                            Text("\(selectedBook.author) | \(selectedBook.publisher)")
                                .font(.system(size: 13))
                        }
                        .onAppear {
                            vm.update(title: selectedBook.title)
                            vm.update(imageName: selectedBook.image)
                            vm.update(author: selectedBook.author)
                            vm.update(publisher: selectedBook.publisher)
                        }
                    } else {
                        Image(systemName: "book")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 100)
                        
                        TextField("도서명", text: $vm.title)
                    }
                    
                    Spacer()
                    
                    Button("검색") {
                        isPresentingBookSearchView = true
                    }
                    .frame(alignment: .trailing)
                    .sheet(isPresented: $isPresentingBookSearchView) {
                        BookSearchView(isPresentingBookSearchView: $isPresentingBookSearchView, selectedBook: $selectedBook)
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
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 60, height: 80)
    }
}

struct NewReviewView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = NewReviewViewModel(reviewList: .constant(BookReview.sampleData))
        NewReviewView(vm: vm, isPresentingNewReviewView: .constant(true))
    }
}
