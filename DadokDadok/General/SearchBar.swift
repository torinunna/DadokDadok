//
//  SearchBar.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 6/15/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(alignment: .center) {
            TextField("도서명/저자/출판사를 입력해주세요", text: $text)
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .foregroundColor(.primary)
                .background(ColorManager.cardColor.opacity(0.2))
                .cornerRadius(6)
            
            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.top, 5)
    }
}
