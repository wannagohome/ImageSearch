//
//  ImageUseCaseMock.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/03.
//

import RxSwift
@testable import ImageSearch

class ImageUseCaseMock: ImageUseCaseType {
    var query: String?
    var sampleDataString: String = ""
    
    func search(query: String) -> Single<[ImageModel]> {
        self.query = query
        return sampleStream()
    }
    
    func loadNextPage() -> Single<[ImageModel]> {
        return sampleStream()
    }
    
    private func sampleStream() -> Single<[ImageModel]> {
        let data = sampleDataString.data(using: .utf8)!
        let sampleResponse = try? Decoder()
            .decode(ImageSearchResponse.self, from: data)
            .documents
            .map { ImageModel(document: $0) }
        
        let sampleError = DecodingError.typeMismatch(
            ImageModel.self,
            .init(codingPath: [],
                  debugDescription: "sample error")
        )
        
        if let response = sampleResponse {
            return .just(response)
        } else {
            return .error(sampleError)
        }
    }
}
