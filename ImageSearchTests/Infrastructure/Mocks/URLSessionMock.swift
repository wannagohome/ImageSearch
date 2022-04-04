//
//  URLSessionMock.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/04.
//

import Foundation
@testable import ImageSearch

class URLSessionDataTaskMock: URLSessionDataTask {
    
    var resumeDidCall: (() -> ())?

    override func resume() {
        resumeDidCall?()
    }
    
    override func cancel() {
        return
    }
}

class URLSessionMock: URLSessionType {
    
    var dataTask: URLSessionDataTaskMock?
    var requestNeedsToFail: Bool = false
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        
        let successResponse = HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: "1.1",
            headerFields: nil
        )
        let failureResponse = HTTPURLResponse(
            url: request.url!,
            statusCode: 400,
            httpVersion: "1.1",
            headerFields: nil
        )
        
        
        let dataTask = URLSessionDataTaskMock()
        dataTask.resumeDidCall = {
            if self.requestNeedsToFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(SampleData.jsonStringHasNextPage.data(using: .utf8), successResponse, nil)
            }
        }
        self.dataTask = dataTask
        return dataTask
    }
    
    
}
