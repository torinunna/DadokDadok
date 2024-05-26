//
//  DIContainer.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/26/24.
//

import Foundation

class DIContainer:  ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
