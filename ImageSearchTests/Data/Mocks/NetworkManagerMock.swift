//
//  NetworkManagerMock.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/02.
//

import XCTest
import RxSwift
@testable import ImageSearch

class NetworkManagerMock: NetworkManagerType {
    var request: URLRequest?
    var sampleDataString: String = ""
    
    func request(_ request: URLRequest) -> Single<Data> {
        self.request = request
        return .just(sampleDataString.data(using: .utf8)!)
    }
}
