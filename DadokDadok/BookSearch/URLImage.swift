//
//  URLImage.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/02.
//

import SwiftUI

struct URLImage: View {
    let urlString: String?
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 80)
                .background(Color.white)
        } else {
            Image("")
                .frame(width: 70, height: 80)
                .background(Color.gray)
                .onAppear {
                    fetchImageData()
                }
        }
    }
    
    private func fetchImageData(){
        guard let urlString = urlString else{
            return
        }
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}
