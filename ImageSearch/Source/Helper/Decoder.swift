//
//  Decoder.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation

final class Decoder: JSONDecoder {
    override init() {
        super.init()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateDecodingStrategy = .formatted(formatter)
    }
}
