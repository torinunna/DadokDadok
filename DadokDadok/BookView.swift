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
        VStack(alignment: .center) {
            Image(systemName: review.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text(review.title)
                .font(.system(size: 13.0))
        }
        .padding()
    }
}

struct BookView_Previews: PreviewProvider {
    static var book = BookReview.sampleData[0]
    
    static var previews: some View {
        BookView(review: book)
    }
}
