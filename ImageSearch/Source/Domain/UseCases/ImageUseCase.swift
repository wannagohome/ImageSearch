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
    func loadNextPage() -> Single<ImageSearchResponse>
}

final class ImageUseCase: ImageUseCaseType {
    
    // MARK: - Properties
    private let repository: ImageRepositoryType
    private var requestInfo: ImageSearchRequest!
    private var isEndOfPages: Bool = false
    
    // MARK: - Initialization
    init(repository: ImageRepositoryType) {
        self.repository = repository
    }
    
    // MARK: - Internal Methods
    func search(query: String) -> Single<ImageSearchResponse> {
        requestInfo = ImageSearchRequest(query: query)

        return repository.search(requestInfo)
            .do(onSuccess: { [weak self] in
                self?.isEndOfPages = $0.meta.isEnd
            })
    }
    
    func loadNextPage() -> Single<ImageSearchResponse> {
        guard !isEndOfPages else {
            return .never()
        }
        requestInfo.page += 1
        
        return repository.search(requestInfo)
            .do(onSuccess: { [weak self] in
                self?.isEndOfPages = $0.meta.isEnd
            })
    }
}
