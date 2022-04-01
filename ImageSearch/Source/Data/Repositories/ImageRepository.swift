//
//  ImageRepository.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation
import RxSwift

protocol ImageRepositoryType {
    func search(_ request: URLRequest) -> Single<ImageSearchResponse>
}

final class ImageRepository: ImageRepositoryType {
    
    // MARK: - Properties
    private let networkManager: NetworkManager
    
    // MARK: - Initialization
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - Internal Methods
    func search(_ request: URLRequest) -> Single<ImageSearchResponse> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return networkManager.request(request)
            .flatMap { data -> Single<ImageSearchResponse> in
                return .just(try decoder.decode(ImageSearchResponse.self, from: data))
            }
    }
}
