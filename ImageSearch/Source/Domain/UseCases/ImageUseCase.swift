//
//  ImageUseCase.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation
import RxSwift

protocol ImageUseCaseType {
    func search(query: String, page: Int, size: Int) -> Single<ImageSearch>
}

final class ImageUseCase: ImageUseCaseType {
    
    // MARK: - Properties
    private let repository: ImageRepositoryType
    
    // MARK: - Initialization
    init(repository: ImageRepositoryType) {
        self.repository = repository
    }
    
    // MARK: - Internal Methods
    func search(query: String, page: Int, size: Int) -> Single<ImageSearch> {
        var components = URLComponents(string: "https://dapi.kakao.com/v2/search/vclip")!
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "size", value: "\(size)")
        ]
        
        var request = URLRequest(url: components.url!)
        request.allHTTPHeaderFields = ["Authorization" : "KakaoAK \(Environment.apiKey)"]


        return repository.search(request)
    }
}
