//
//  ImageRepositoryMock.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/02.
//

import RxSwift
@testable import ImageSearch

class ImageRepositoryMock: ImageRepositoryType {
    var parameter: ImageSearchRequest?
    var sampleDataString: String = ""
    
    func search(_ parameter: ImageSearchRequest) -> Single<ImageSearchResponse> {
        self.parameter = parameter
        
        let data = sampleDataString.data(using: .utf8)!
        let sampleResponse = try! Decoder().decode(ImageSearchResponse.self, from: data)
        return .just(sampleResponse)
    }
}
