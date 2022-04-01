//
//  ImageRepository.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation
import RxSwift

protocol ImageRepositoryType {
    func search(_ parameter: ImageSearchRequest) -> Single<ImageSearchResponse>
}

final class ImageRepository: ImageRepositoryType {
    
    // MARK: - Properties
    private let networkManager: NetworkManager
    
    // MARK: - Initialization
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - Internal Methods
    func search(_ parameter: ImageSearchRequest) -> Single<ImageSearchResponse> {
        var components = URLComponents(string: "https://dapi.kakao.com/v2/search/image")!
        components.queryItems = parameter.toQueryItem()
        var request = URLRequest(url: components.url!)
        request.allHTTPHeaderFields = ["Authorization" : "KakaoAK \(Environment.apiKey)"]
        
        return networkManager.request(request)
            .flatMap { data -> Single<ImageSearchResponse> in
                return .just(try Decoder().decode(ImageSearchResponse.self, from: data))
            }
    }
}
