//
//  ImageRepositoryTest.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/02.
//

import Foundation
import XCTest
import RxTest
import RxBlocking
@testable import ImageSearch

class ImageRepositoryTest: XCTestCase {
    private var repository: ImageRepository!
    private var networkManager: NetworkManagerMock!
    var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManagerMock()
        repository = ImageRepository(networkManager: networkManager)
        scheduler = TestScheduler(initialClock: 0)
    }
    
    func testSearch_endPointURL() {
        //when
        let _ = repository.search(ImageSearchRequest(query: "q"))
        
        //then
        if let url = networkManager.request?.url {
            XCTAssertEqual(url.scheme, "https")
            XCTAssertEqual(url.host, "dapi.kakao.com")
            XCTAssertEqual(url.path, "/v2/search/image")
        } else {
            XCTFail("wrong url")
        }
    }
    
    func testSeacrh_mustContainSearchTestQueryWhichNonEmpty() {
        //given
        let searchQuery = ImageSearchRequest(query: "q")
        
        //when
        let _ = repository.search(searchQuery)
        
        //then
        if let url = networkManager.request?.url,
           let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
           let queryItems = components.queryItems {
            
            XCTAssertTrue(queryItems.count > 1)
            XCTAssertTrue(queryItems.map { $0.name }.contains("query"))
            XCTAssertEqual(queryItems.first { $0.name == "query" }?.value, searchQuery.query)
        } else {
            XCTFail("wrong url")
        }
    }
    
    func testSearch_returnsImageSearchResponse() {
        //given
        let response = scheduler.createObserver(ImageSearchResponse.self)
        networkManager.sampleDataString = SampleData.jsonStringHasNextPage
        
        //when
        repository.search(ImageSearchRequest(query: "abcd"))
            .asObservable()
            .bind(to: response)
            .dispose()
        
        //then
        XCTAssertNotNil(response.events.first?.value.element)
    }
    
    func testSearch_returnsError() {
        //given
        networkManager.sampleDataString = SampleData.jsonStringTypeMismatch
        
        //when
        let result = repository.search(ImageSearchRequest(query: "abcd"))
            .toBlocking()
            .materialize()
        
        //then
        switch result {
        case .completed:
            XCTFail()
        case .failed(_, let error):
            XCTAssertTrue(error is DecodingError)
        }
    }
}
