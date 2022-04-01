//
//  Environment.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/01.
//

import Foundation

struct Environment {
    static var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "IMAGE_API_KEY") as! String
    }
}
