//
//  SearchReactorTests.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/03.
//

@testable import ImageSearch
import XCTest
import RxTest
import RxSwift

class SearchReactorTests: XCTestCase {
    var reactor: SearchReactor!
    var usecase: ImageUseCaseMock!
    var presenter: SearchViewPresenterMock!
    var scheduler: TestScheduler!
    
    override func setUp() {
        presenter = SearchViewPresenterMock()
        usecase = ImageUseCaseMock()
        reactor = SearchReactor(usecase: usecase, presenter: presenter)
        scheduler = TestScheduler(initialClock: 0)
    }
    
    func testAction_search() {
        //given
        usecase.sampleDataString = SampleData.jsonStringHasNextPage
        
        //when
        reactor.action.onNext(.typeSearchText("abcd"))
        
        //then
        XCTAssertEqual(reactor.currentState.images.count, 3)
        XCTAssertEqual(usecase.query, "abcd")
    }
    
    func testAction_searchError() {
        //given
        usecase.sampleDataString = SampleData.jsonStringTypeMismatch
        
        //when
        reactor.action.onNext(.typeSearchText("abcd"))
        
        //then
        XCTAssertNotNil(reactor.currentState.alertMessage)
    }
    
    func testAction_selectImage_afterSearch_presentDetailShouldInvoked() {
        //given
        usecase.sampleDataString = SampleData.jsonStringHasNextPage
        reactor.action.onNext(.typeSearchText("abcd"))
        
        //when
        reactor.action.onNext(.selectImageAt(IndexPath(row: 0, section: 0)))
        
        //then
        XCTAssertNotNil(presenter.imageModel)
    }
    
    func testAction_selectImage_beforeSearch_NothingHappens() {
        //given
        usecase.sampleDataString = SampleData.jsonStringHasNextPage
        
        //when
        reactor.action.onNext(.selectImageAt(IndexPath(row: 0, section: 0)))
        
        //then
        XCTAssertNil(presenter.imageModel)
    }
    
    func testAction_hitsBottom_beforeSearch_NothingHappens() {
        //given
        usecase.sampleDataString = SampleData.jsonStringHasNextPage
        
        //when
        reactor.action.onNext(.hitsBottom)
        
        //then
        XCTAssertTrue(reactor.currentState.images.isEmpty)
    }
    
    func testAction_hitsBottom_afterSearch() {
        //given
        usecase.sampleDataString = SampleData.jsonStringHasNextPage
        reactor.action.onNext(.typeSearchText("abcd"))
        
        //when
        reactor.action.onNext(.hitsBottom)
        
        //then
        XCTAssertEqual(reactor.currentState.images.count, 6)
    }
    
    func testAction_hitsBottom_afterSearchError() {
        //given
        usecase.sampleDataString = SampleData.jsonStringHasNextPage
        reactor.action.onNext(.typeSearchText("abcd"))
        
        //when
        usecase.sampleDataString = SampleData.jsonStringTypeMismatch
        reactor.action.onNext(.hitsBottom)
        
        //then
        XCTAssertNotNil(reactor.currentState.alertMessage)
    }
}
