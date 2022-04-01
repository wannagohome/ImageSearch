//
//  ImageDocument.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation

struct ImageDocument: Codable {
    let collection: String
    let thumbnailURL: URL
    let imageURL: URL
    let width: Int
    let height: Int
    let displaySitename: String
    let datetime: Date
    
    enum CodingKeys: String, CodingKey {
        case collection
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
        case width, height
        case displaySitename = "display_sitename"
        case datetime
    }
}
