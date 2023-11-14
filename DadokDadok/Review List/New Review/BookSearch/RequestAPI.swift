//
//  RequestAPI.swift
//  DadokDadok
//
//  Created by YUJIN KWON on 2023/11/02.
//

import Foundation
import Alamofire

class RequestAPI: ObservableObject {
    static let shared = RequestAPI()
    
    private init() { }
    
    @Published var bookList = [Book]()
    
    func requestSearchBookList(query: String) {
        let baseURL = "https://openapi.naver.com/v1/search/book.json"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": Hide().naverClientID,
            "X-Naver-Client-Secret": Hide().naverClientSecret,
        ]
        
        let parameters: Parameters = [
            "query": query,
            "display": 50
        ]
        
        AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate(statusCode: 200...500)
        .responseDecodable(of: BookList.self) { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        self.bookList = data.items
                    }
                }
                print("\(#file) > \(#function) :: SUCCESS")
            case .failure(let error):
                print("\(#file) > \(#function) :: FAILURE : \(error)")
            }
        }
    }
}
