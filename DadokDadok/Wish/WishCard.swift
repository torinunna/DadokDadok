//
//  WishCard.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/31/23.
//

import SwiftUI

struct WishCard: View {
    var wish: Wish
    @Environment(\.openURL) private var openURL
    @EnvironmentObject var vm: WishlistViewModel
    @State private var isImageMagnified: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 15) {
                BookCover(imageString: wish.book.image)
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
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                    }
                    .foregroundStyle(ColorManager.accentColor)
                    .buttonStyle(PlainButtonStyle())
                }
                
                Button {
                    vm.send(action: .toggleFavorite(wish))
                } label: {
                    (wish.isFavorite ? Image(systemName: "heart.fill") : Image(systemName: "heart"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
                .foregroundStyle(ColorManager.accentColor)
                .buttonStyle(PlainButtonStyle())
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(ColorManager.cardColor)
        }
        .background(ColorManager.backgroundColor)
        .popover(isPresented: $isImageMagnified) {
            BookCover(imageString: wish.book.image)
                .frame(width: 250, height: 250)
                .presentationCompactAdaptation(.popover)
        }
    }
}
