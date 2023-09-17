//
//  DadokDadokApp.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

@main
struct DadokDadokApp: App {
    @State private var reviews = BookReview.sampleData
    
    var body: some Scene {
        WindowGroup {
            ContentView(reviews: $reviews)
        }
    }
}
