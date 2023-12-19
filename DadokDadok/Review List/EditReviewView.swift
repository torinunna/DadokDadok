//
//  EditReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct EditReviewView: View {
    @Binding var bookReview: BookReview
    @State private var selectedDate = Date()
    
    init(bookReview: Binding<BookReview>) {
        _bookReview = bookReview
        _selectedDate = State(initialValue: Self.dateFormatter.date(from: bookReview.wrappedValue.date) ?? Date())
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 15) {
                fetchImage(url: bookReview.imageName)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(bookReview.title)
                        .font(.system(size: 14, weight: .semibold))
                    Text("\(bookReview.author) | \(bookReview.publisher)")
                        .font(.system(size: 13))
                    Text(bookReview.isbn)
                        .font(.system(size: 12))
                }
                Spacer()
            }
            
            DatePicker("읽은 날짜", selection: $selectedDate, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ko-KR"))
            
            TextEditor(text: $bookReview.review)
                .border(.gray.opacity(0.2), width: 3)
        }
        .padding(.horizontal)
        
        .onChange(of: selectedDate, perform: { newDate in
            bookReview.date = Self.dateFormatter.string(from: newDate)
        })
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
        EditReviewView(bookReview: .constant(BookReview.sampleData[0]))
    }
}
