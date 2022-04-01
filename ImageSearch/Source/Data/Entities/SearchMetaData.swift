//
//  SearchMetaData.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

struct SearchMetaData: Codable {
    let totalCount: Int
    let pageableCount: Int
    let isEnd: Int
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}
