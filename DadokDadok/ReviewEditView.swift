//
//  ReviewEditView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct ReviewEditView: View {
    @Binding var review: BookReview
    @State private var selectedDate = Date()
    
    init(review: Binding<BookReview>) {
        _review = review
        _selectedDate = State(initialValue: Self.dateFormatter.date(from: review.wrappedValue.date) ?? Date())
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 20) {
                Image(systemName: review.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 100)
                
                Text(review.title)
            }
            .padding()
            
            DatePicker("읽은 날짜", selection: $selectedDate, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ko-KR"))
            
            TextEditor(text: $review.review)
                .border(.gray.opacity(0.2), width: 3)
        }
        .padding()
        
        .onChange(of: selectedDate, perform: { newDate in
            review.date = Self.dateFormatter.string(from: newDate)
        })
    }
}

struct ReviewEditView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewEditView(review: .constant(BookReview.sampleData[0]))
    }
}
