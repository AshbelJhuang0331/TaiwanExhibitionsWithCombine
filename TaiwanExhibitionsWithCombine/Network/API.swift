//
//  API.swift
//  TaiwanExhibitions
//
//  Created by Chuan-Jie Jhuang on 2022/3/16.
//

import Foundation
import Combine

class API: NSObject {
        
    private struct URI {
        static let scheme = "https"
        static let host = "cloud.culture.tw"
        static let path = "/frontsite/trans/SearchShowAction.do"
        static let defaultQuery = ""
    }
    
    private var urlComponents = URLComponents()
    private let session = URLSession.shared
    private var requestCancellable: AnyCancellable?
    
    override init() {
        super.init()
        urlComponents.scheme = URI.scheme
        urlComponents.host = URI.host
        urlComponents.path = URI.path
    }
    
    func requestAllExhibitions(success: @escaping ([ExhibitionModel]) -> (), failure: @escaping (Error) -> ()) {
        self.urlComponents.queryItems = [
            "method": "doFindTypeJ",
            "category": "6"
        ].map{ URLQueryItem(name: $0.key, value: $0.value) }
        let url = urlComponents.url
        let urlRequest = URLRequest(url: url!)
        
        requestCancellable?.cancel()
        requestCancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { [weak self] data, response -> [ExhibitionModel] in
                print("data: \(data)\nresponse: \(response)")
                return self?.decodeAllExhibitions(data) ?? []
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    failure(error)
                }
            }, receiveValue: { result in
                success(result)
            })
    }
    
    private func decodeAllExhibitions(_ data: Data) -> [ExhibitionModel] {
        if let allExhibitions = try? JSONDecoder().decode([ExhibitionModel].self, from: data) {
            return allExhibitions
        } else {
            return []
        }
    }
    
}
