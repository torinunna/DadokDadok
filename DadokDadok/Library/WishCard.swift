//
//  WishCard.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/31/23.
//

import SwiftUI

struct WishCard: View {
    var wish: Wish
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            fetchImage(url: wish.imageName)
            
            VStack(alignment: .leading) {
                Text(wish.title)
                    .font(.system(size: 14.0, weight: .semibold))
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                Text(wish.author)
                    .font(.system(size: 13.0, weight: .medium))
                Text(wish.publisher)
                    .font(.system(size: 13.0, weight: .medium))
            }
            
            Spacer()
            Image(systemName: "star.fill")
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
    WishCard(wish: Wish.sampleData[0])
}
