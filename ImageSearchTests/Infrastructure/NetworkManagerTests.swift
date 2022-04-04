//
//  NetworkManagerTests.swift
//  ImageSearchTests
//
//  Created by CW on 2022/04/04.
//

import XCTest
import RxTest
@testable import ImageSearch

class NetworkManagerTests: XCTestCase {
    var session: URLSessionMock!
    var networkManager: NetworkManager!
    var scheduler: TestScheduler!
    
    
    override func setUp() {
        session = URLSessionMock()
        networkManager = NetworkManager(session: session)
        scheduler = TestScheduler(initialClock: 0)
    }
    
    func test_requestSuccess() {
        //given
        let response = scheduler.createObserver(Data.self)
        session.requestNeedsToFail = false
        
        //when
        networkManager
            .request(URLRequest(url: URL(string: "https://dapi.kakao.com/v2/search/image")!))
            .asObservable()
            .bind(to: response)
            .dispose()
        
        //then
        XCTAssertNotNil(response.events.first?.value.element)
    }
    
    func test_requestFail() {
        //given
        session.requestNeedsToFail = true
        
        //given
        let result = networkManager
            .request(URLRequest(url: URL(string: "https://dapi.kakao.com/v2/search/image")!))
            .toBlocking()
            .materialize()
        
        //then
        switch result {
        case .completed:
            XCTFail()
        case .failed:
            XCTAssert(true)
        }
    }
}
