//
//  BookView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct BookView: View {
    var review: BookReview
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            fetchImage(url: review.imageName)
            
            Text(review.title)
                .font(.system(size: 13.0, weight: .semibold))
        }
        .padding()
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(width: 90, height: 120)
    }
}

struct BookView_Previews: PreviewProvider {
    static var book = BookReview.sampleData[0]
    
    static var previews: some View {
        BookView(review: book)
    }
}
