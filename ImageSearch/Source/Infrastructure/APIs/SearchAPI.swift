//
//  SearchAPI.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/04/04.
//

struct SearchAPI {
    static func getAPI(_ parameter: ImageSearchRequest) -> API {
        API(host: "dapi.kakao.com",
            path: "/v2/search/image",
            parameter: parameter)
    }
}
