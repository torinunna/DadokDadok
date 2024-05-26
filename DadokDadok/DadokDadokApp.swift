//
//  DadokDadokApp.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/09/17.
//

import SwiftUI

@main
struct DadokDadokApp: App {
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(container)
        }
    }
}
