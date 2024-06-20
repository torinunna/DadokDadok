//
//  BookCover.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 6/20/24.
//

import SwiftUI

struct BookCover: View {
    var imageString: String
    
    var body: some View {
        if let data = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters){
            let image = UIImage(data: data)
            Image(uiImage: image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            fetchImage(url: imageString)
        }
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "book")
        }
    }
}
