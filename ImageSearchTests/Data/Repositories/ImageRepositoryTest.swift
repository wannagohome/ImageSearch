//
//  ImageRepositoryTest.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/02.
//

import Foundation
import XCTest
@testable import ImageSearch

class ImageRepositoryTest: XCTestCase {
    private var repository: ImageRepository!
    private var networkManager: NetworkManagerMock!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManagerMock()
        repository = ImageRepository(networkManager: networkManager)
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
}
