//
//  BookReviewView.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/18.
//

import SwiftUI

struct BookReviewView: View {
    @EnvironmentObject var container: DIContainer
    @ObservedObject var vm: BookReviewViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) private var openURL
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            BookCover(bookReview: vm.bookReview)
            
            Divider()
                .padding(5)
            
            HStack {
                Spacer()
                DatePicker("읽은 날짜", selection: $vm.reviewDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .environment(\.locale, Locale.init(identifier: "ko-KR"))
                    .font(.footnote)
                    .fontWeight(.medium)
                
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(ColorManager.cardColor.opacity(0.6))
                ScrollView {
                    VStack(alignment: .leading) {
                        TextEditor(text: $vm.bookReview.review)
                            .font(.system(size: 15))
                            .scrollContentBackground(.hidden) 
                            .background(Color.clear)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            
            HStack {
                Spacer()
                
                Button {
                    showAlert = true
                } label: {
                    Text("삭제하기")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.white)
                        .background(ColorManager.redColor)
                        .cornerRadius(10)
                }
                .alert("서평을 삭제하시겠습니까?", isPresented: $showAlert) {
                    Button {
                    } label: {
                        Text("취소")
                    }
                    
                    Button {
                        vm.delete()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("삭제")
                    }
                }
                                
                Spacer()
                
                Button {
                    vm.save()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("저장하기")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.white)
                        .background(ColorManager.accentColor)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(ColorManager.backgroundColor)
        .toolbar {
            if !vm.bookReview.book.link.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        openURL(URL(string: vm.bookReview.book.link)!)
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.fetch()
        }
    }
}
