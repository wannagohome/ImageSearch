//
//  ImageModel.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation

struct ImageModel {
    let thumbnailURL: URL
    let imageURL: URL
    let displaySitename: String
    let datetime: Date
    
    init(document: ImageDocument) {
        self.thumbnailURL = document.thumbnailURL
        self.imageURL = document.imageURL
        self.displaySitename = document.displaySitename
        self.datetime = document.datetime
    }
}
