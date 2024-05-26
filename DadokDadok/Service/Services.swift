//
//  Services.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 5/26/24.
//

import Foundation

protocol ServiceType {
    var reviewStorageService: ReviewStorageServiceType { get set }
    var wishStorageService: WishStorageServiceType { get set }
}

class Services: ServiceType {
    var reviewStorageService: ReviewStorageServiceType
    var wishStorageService: WishStorageServiceType
    
    init() {
        self.reviewStorageService = ReviewStorageService()
        self.wishStorageService = WishStorageService()
    }
}
