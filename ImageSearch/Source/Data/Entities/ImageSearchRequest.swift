//
//  ImageSearchRequest.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

struct ImageSearchRequest: Codable {
    var query: String
    var page: Int
    var size: Int = 30
}
