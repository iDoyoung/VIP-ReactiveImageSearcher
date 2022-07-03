//
//  Seeds.swift
//  ReactiveImageSearcherTests
//
//  Created by Doyoung on 2022/06/24.
//

import XCTest
@testable import UnReactiveImageSearcher

struct Seeds {
    
    struct Photos {
        static let imageURL = Photo.ImageURL(raw: "", full: "", regular: "", small: "", thumb: "", small_s3: "")
        static let randomPhoto = Photo(id: "1",
                                       created_at: "2022-06-24T10:10:29-04:00",
                                       updated_at: "2022-06-24T10:10:29-04:00",
                                       promoted_at: "2022-06-24T10:10:29-04:00",
                                       urls: imageURL)
    }
    
}
