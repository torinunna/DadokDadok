//
//  NewWishView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 12/31/23.
//

import SwiftUI

struct NewWishView: View {
    @State private var newWish = Wish.emptyWish
    @Binding var isPresentingNewWishView: Bool
    @Binding var wishList: [Wish]
    @State private var isPresentingBookSearchView = false
    @State private var selectedView: Views = .searchBookView
    
    enum Views {
        case searchBookView
        case userInputView
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("select view", selection: $selectedView) {
                    Text("책 검색하기").tag(Views.searchBookView)
                    Text("직접 입력하기").tag(Views.userInputView)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.top)
                
                if selectedView == .searchBookView {
                    SearchView()
                } else {
                    UserInputView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        isPresentingNewWishView = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        wishList.append(newWish)
                        isPresentingNewWishView = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Search View

struct SearchView: View {
    var body: some View {
        Text("Search Book View")
        
    }
}


// MARK: - User Input

struct UserInputView: View {
    var body: some View {
        Text("User Input View")
        
    }
}
