//
//  ImageSearch.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

struct ImageSearchResponse: Codable {
    let meta: SearchMetaData
    let documents: [ImageDocument]
}
