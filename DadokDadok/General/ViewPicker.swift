//
//  ViewPicker.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/27/24.
//

import SwiftUI

enum Views {
    case searchBookView
    case userInputView
}

struct ViewPicker: View {
    @Binding var selectedView: Views
    
    var body: some View {
        Picker("select view", selection: $selectedView) {
            Text("책 검색하기")
                .tag(Views.searchBookView)
            Text("직접 입력하기")
                .tag(Views.userInputView)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
}
