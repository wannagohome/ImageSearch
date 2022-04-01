//
//  ImageDocument.swift
//  ImageSearch
//
//  Created by CW on 2022/04/01.
//

import Foundation

struct ImageDocument: Codable {
    let collection: String
    let thumbnailURL: URL
    let imageURL: URL
    let width: Int
    let height: Int
    let displaySitename: String
    let docURL: URL
    let datetime: Date
    
    enum CodingKeys: String, CodingKey {
        case collection
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
        case width, height
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case datetime
    }
}
