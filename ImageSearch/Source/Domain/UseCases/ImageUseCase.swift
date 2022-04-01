//
//  ImageUseCase.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation
import RxSwift

protocol ImageUseCaseType {
    func search(query: String) -> Single<ImageSearchResponse>
}

final class ImageUseCase: ImageUseCaseType {
    
    // MARK: - Properties
    private let repository: ImageRepositoryType
    private var requestInfo: ImageSearchRequest?
    
    // MARK: - Initialization
    init(repository: ImageRepositoryType) {
        self.repository = repository
    }
    
    // MARK: - Internal Methods
    func search(query: String) -> Single<ImageSearchResponse> {
        requestInfo = ImageSearchRequest(query: query)
        
        var components = URLComponents(string: "https://dapi.kakao.com/v2/search/vclip")!
        components.queryItems = requestInfo.toQueryItem()
        var request = URLRequest(url: components.url!)
        request.allHTTPHeaderFields = ["Authorization" : "KakaoAK \(Environment.apiKey)"]


        return repository.search(request)
    }
}
