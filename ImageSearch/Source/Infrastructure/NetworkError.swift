//
//  NetworkError.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/03/31.
//

import Foundation

enum NetworkError: Error {
    case http(statusCode: Int)
    case noData
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .http(let statusCode):
            return "Network error : \(statusCode)"
        case .noData:
            return "Network error : empty data"
        }
    }
}
