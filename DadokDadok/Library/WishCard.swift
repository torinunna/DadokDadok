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
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            fetchImage(url: wish.book.image)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(wish.book.title)
                    .font(.system(size: 14.0, weight: .semibold))
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 3)
                Text(wish.book.author)
                    .font(.system(size: 12.0, weight: .medium))
                Text(wish.book.publisher)
                    .font(.system(size: 12.0, weight: .medium))
            }
            
            Spacer()
            
            if !wish.book.link.isEmpty {
                Button {
                    openURL(URL(string: wish.book.link)!)
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            
            Button {
                wish.isFavorite.toggle()
                print(wish.isFavorite)
            } label: {
                wish.isFavorite ? Image(systemName: "star.fill") : Image(systemName: "star")
            }
            .foregroundStyle(Color.yellow)
        }
        .padding(.horizontal)
    }
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "book")
        }
        .frame(width: 60, height: 80)
    }
}

#Preview {
    WishCard(wish: .constant(Wish.sampleData[0]))
}
