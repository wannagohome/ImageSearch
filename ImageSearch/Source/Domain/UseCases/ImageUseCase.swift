//
//  ImageUseCase.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation
import RxSwift

protocol ImageUseCaseType {
    func search(query: String) -> Single<[ImageModel]>
    func loadNextPage() -> Single<[ImageModel]>
}

final class ImageUseCase: ImageUseCaseType {
    
    // MARK: - Properties
    private let repository: ImageRepositoryType
    private var requestInfo: ImageSearchRequest!
    private var isEndOfPages: Bool = false
    private var isLoading: Bool = false
    
    // MARK: - Initialization
    init(repository: ImageRepositoryType) {
        self.repository = repository
    }
    
    // MARK: - Internal Methods
    func search(query: String) -> Single<[ImageModel]> {
        requestInfo = ImageSearchRequest(query: query)

        return sendRequest()
    }
    
    func loadNextPage() -> Single<[ImageModel]> {
        guard !isEndOfPages && !isLoading else {
            return .never()
        }
        requestInfo.page += 1
        
        return sendRequest()
    }
    
    private func sendRequest() -> Single<[ImageModel]> {
        self.isLoading = true
        return repository.search(requestInfo)
            .do(onSuccess: { [weak self] in
                self?.isLoading = false
                self?.isEndOfPages = $0.meta.isEnd
            })
            .map { res in
                res.documents.map { ImageModel(document: $0) }
            }
    }
}
