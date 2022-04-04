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
    private let networkManager: NetworkManagerType
    
    // MARK: - Initialization
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    // MARK: - Internal Methods
    func search(_ parameter: ImageSearchRequest) -> Single<ImageSearchResponse> {
        networkManager.request(SearchAPI.getAPI(parameter).request)
            .flatMap { data -> Single<ImageSearchResponse> in
                return .just(try Decoder().decode(ImageSearchResponse.self, from: data))
            }
    }
}
