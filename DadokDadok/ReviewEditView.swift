//
//  ReviewEditView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct ReviewEditView: View {
    @Binding var review: BookReview
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Image(systemName: review.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 100)
                
                TextField("도서명", text: $review.title)
            }
            .padding()
            
            TextEditor(text: $review.review)
                .border(.gray.opacity(0.2), width: 3)
        }
        .padding()
    }
}

struct ReviewEditView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewEditView(review: .constant(BookReview.sampleData[0]))
    }
}
