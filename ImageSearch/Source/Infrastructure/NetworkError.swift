//
//  NetworkError.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/03/31.
//

enum NetworkError: Error {
    case http(statusCode: Int)
    case noData
}
