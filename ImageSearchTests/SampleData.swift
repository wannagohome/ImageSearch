//
//  SampleData.swift
//  ImageSearchTests
//
//  Created by Jinho Jang on 2022/04/02.
//

struct SampleData {
    static let jsonStringHasNextPage: String = """
{
    "documents": [
        {
            "collection": "cafe",
            "datetime": "2013-05-29T16:26:39.000+09:00",
            "display_sitename": "Daum카페",
            "doc_url": "http://cafe.daum.net/LHKOREA12/GLUq/243",
            "height": 450,
            "image_url": "http://file.designdb.com/EDITOR/81/5680620130505211756.jpg",
            "thumbnail_url": "https://search3.kakaocdn.net/argon/130x130_85_c/35dB9vCosas",
            "width": 660
        },
        {
            "collection": "blog",
            "datetime": "2013-02-23T12:36:00.000+09:00",
            "display_sitename": "네이버블로그",
            "doc_url": "http://blog.naver.com/amatte/100180531975",
            "height": 383,
            "image_url": "http://postfiles2.naver.net/20130223_97/amatte_1361590534312BRicq_JPEG/ABCD-3.jpg?type=w2",
            "thumbnail_url": "https://search2.kakaocdn.net/argon/130x130_85_c/Jy59jETiMNk",
            "width": 680
        },
        {
            "collection": "blog",
            "datetime": "2013-02-23T12:36:00.000+09:00",
            "display_sitename": "네이버블로그",
            "doc_url": "http://blog.naver.com/amatte/100180531975",
            "height": 493,
            "image_url": "http://postfiles12.naver.net/20130223_219/amatte_1361590533057h3GpO_JPEG/ABCD_Pic.jpg?type=w2",
            "thumbnail_url": "https://search1.kakaocdn.net/argon/130x130_85_c/CxLUWFhE3pX",
            "width": 740
        }
    ],
    "meta": {
        "is_end": false,
        "pageable_count": 3927,
        "total_count": 113608
    }
}
"""
    
    
    static let jsonStringNoNextPage: String = """
{
    "documents": [
        {
            "collection": "cafe",
            "datetime": "2013-05-29T16:26:39.000+09:00",
            "display_sitename": "Daum카페",
            "doc_url": "http://cafe.daum.net/LHKOREA12/GLUq/243",
            "height": 450,
            "image_url": "http://file.designdb.com/EDITOR/81/5680620130505211756.jpg",
            "thumbnail_url": "https://search3.kakaocdn.net/argon/130x130_85_c/35dB9vCosas",
            "width": 660
        },
        {
            "collection": "blog",
            "datetime": "2013-02-23T12:36:00.000+09:00",
            "display_sitename": "네이버블로그",
            "doc_url": "http://blog.naver.com/amatte/100180531975",
            "height": 383,
            "image_url": "http://postfiles2.naver.net/20130223_97/amatte_1361590534312BRicq_JPEG/ABCD-3.jpg?type=w2",
            "thumbnail_url": "https://search2.kakaocdn.net/argon/130x130_85_c/Jy59jETiMNk",
            "width": 680
        },
        {
            "collection": "blog",
            "datetime": "2013-02-23T12:36:00.000+09:00",
            "display_sitename": "네이버블로그",
            "doc_url": "http://blog.naver.com/amatte/100180531975",
            "height": 493,
            "image_url": "http://postfiles12.naver.net/20130223_219/amatte_1361590533057h3GpO_JPEG/ABCD_Pic.jpg?type=w2",
            "thumbnail_url": "https://search1.kakaocdn.net/argon/130x130_85_c/CxLUWFhE3pX",
            "width": 740
        }
    ],
    "meta": {
        "is_end": true,
        "pageable_count": 3927,
        "total_count": 113608
    }
}
"""
    
    static let jsonStringTypeMismatch: String = """
{
    "documents": [
        {
            "collection": "cafe",
            "datetime": "2013-05-29T16:26:39.000+09:00",
            "display_sitename": "Daum카페",
            "doc_url": 123,
            "height": "asdfae",
            "image_url": "http://file.designdb.com/EDITOR/81/5680620130505211756.jpg",
            "thumbnail_url": "https://search3.kakaocdn.net/argon/130x130_85_c/35dB9vCosas",
            "width": 660
        },
        {
            "collection": "blog",
            "datetime": "2013-02-23T12:36:00.000+09:00",
            "display_sitename": "네이버블로그",
            "doc_url": "http://blog.naver.com/amatte/100180531975",
            "height": 383,
            "image_url": "http://postfiles2.naver.net/20130223_97/amatte_1361590534312BRicq_JPEG/ABCD-3.jpg?type=w2",
            "thumbnail_url": "https://search2.kakaocdn.net/argon/130x130_85_c/Jy59jETiMNk",
            "width": 680
        },
        {
            "collection": "blog",
            "datetime": "2013-02-23T12:36:00.000+09:00",
            "display_sitename": "네이버블로그",
            "doc_url": "http://blog.naver.com/amatte/100180531975",
            "height": 493,
            "image_url": "http://postfiles12.naver.net/20130223_219/amatte_1361590533057h3GpO_JPEG/ABCD_Pic.jpg?type=w2",
            "thumbnail_url": "https://search1.kakaocdn.net/argon/130x130_85_c/CxLUWFhE3pX",
            "width": 740
        }
    ],
    "meta": {
        "is_end": true,
        "pageable_count": 3927,
        "total_count": 113608
    }
}
"""
}
