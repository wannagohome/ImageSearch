//
//  ImageUseCaseTests.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/02.
//

import XCTest
import RxTest
import RxSwift
@testable import ImageSearch

class ImageUseCaseTests: XCTestCase {
    var usecase: ImageUseCase!
    var repository: ImageRepositoryMock!
    var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        repository = ImageRepositoryMock()
        usecase = ImageUseCase(repository: repository)
        scheduler = TestScheduler(initialClock: 0)
    }
    
    func test_whenSearch_thenPageNumberInQueryIs1() {
        //given
        let query = "abcd"
        repository.sampleDataString = SampleData.jsonStringHasNextPage
        
        //when
        usecase.search(query: query).subscribe().dispose()
        
        //then
        XCTAssertEqual(repository.parameter?.page, 1)
    }
    
    func test_whenSearch_thenPageSizeInQueryIs30() {
        //given
        let query = "abcd"
        repository.sampleDataString = SampleData.jsonStringHasNextPage
        
        //when
        usecase.search(query: query).subscribe().dispose()
        
        //then
        XCTAssertEqual(repository.parameter?.size, 30)
    }
    
    func test_whenSearch_thenQueryStringIsSameWithParameter() {
        //given
        let query = "abcd"
        repository.sampleDataString = SampleData.jsonStringHasNextPage
        
        //when
        usecase.search(query: query).subscribe().dispose()
        
        //then
        XCTAssertEqual(repository.parameter?.query, query)
    }
    
    func test_whenSearch_thenReturnData() {
        //given
        let query = "abcd"
        let loadNextPage = scheduler.createObserver([ImageModel].self)
        repository.sampleDataString = SampleData.jsonStringHasNextPage
        
        //when
        usecase.search(query: query)
            .asObservable()
            .bind(to: loadNextPage)
            .disposed(by: DisposeBag())
        
        //then
        XCTAssertEqual(loadNextPage.events.first?.value.element?.count, 3)
    }
    
    func test_givenSearchHasNextPage_whenLoadNextPage_thenPageNumberInQueryIs2() {
        //given
        let query = "abcd"
        repository.sampleDataString = SampleData.jsonStringHasNextPage
        usecase.search(query: query).subscribe().dispose()
        
        //when
        usecase.loadNextPage().subscribe().dispose()
        
        //then
        XCTAssertEqual(repository.parameter?.page, 2)
    }
    
    func test_givenSearchDontHaveNextPage_whenLoadNextPage_thenDoNotLoad() {
        //given
        let query = "abcd"
        let loadNextPage = scheduler.createObserver([ImageModel].self)
        repository.sampleDataString = SampleData.jsonStringNoNextPage
        usecase.search(query: query).subscribe().dispose()
        
        //when
        usecase.loadNextPage()
            .asObservable()
            .bind(to: loadNextPage)
            .disposed(by: DisposeBag())
        
        //then
        XCTAssertEqual(loadNextPage.events.count, 0)
    }
}
