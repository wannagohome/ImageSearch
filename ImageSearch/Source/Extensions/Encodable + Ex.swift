//
//  Encodable + Ex.swift
//  ImageSearch
//
//  Created by CW on 2022/04/01.
//

import Foundation

extension Encodable {
    func toQueryItem() -> [URLQueryItem] {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            fatalError("\(Self.self) can not ")
        }
        
        return dictionary.map { key, value -> URLQueryItem in
            URLQueryItem(name: key, value: "\(value)")
        }
    }
}
