//
//  WishCard.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/31/23.
//

import SwiftUI

struct WishCard: View {
    @Binding var wish: Wish
    @Environment(\.openURL) private var openURL
    @State private var isImageMagnified: Bool = false
    var toggleFavorite: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            BookImageView(wish: wish)
                .frame(width: 60, height: 80)
                .onTapGesture {
                    isImageMagnified = true
                }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(wish.book.title)
                    .font(.system(size: 14.0, weight: .semibold))
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 3)
                
                if !wish.book.author.isEmpty {
                    Text(wish.book.author)
                        .font(.system(size: 12.0, weight: .medium))
                }
                
                if !wish.book.publisher.isEmpty {
                    Text(wish.book.publisher)
                        .font(.system(size: 12.0, weight: .medium))
                }
            }
            
            Spacer()
            
            if !wish.book.link.isEmpty {
                Button {
                    openURL(URL(string: wish.book.link)!)
                } label: {
                    Image(systemName: "info.circle")
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Button {
                toggleFavorite()
            } label: {
                wish.isFavorite ? Image(systemName: "star.fill") : Image(systemName: "star")
            }
            .foregroundStyle(ColorManager.accentColor)
            .buttonStyle(PlainButtonStyle())
        }
        .background(ColorManager.backgroundColor)
        .popover(isPresented: $isImageMagnified) {
            BookImageView(wish: wish)
                .frame(width: 250, height: 250)
                .presentationCompactAdaptation(.popover)
        }
    }
}


// MARK: - book image view

struct BookImageView: View {
    var wish: Wish
    
    var body: some View {
        if let data = Data(base64Encoded: wish.book.image, options: .ignoreUnknownCharacters){
            let image = UIImage(data: data)
            Image(uiImage: image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            fetchImage(url: wish.book.image)
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
