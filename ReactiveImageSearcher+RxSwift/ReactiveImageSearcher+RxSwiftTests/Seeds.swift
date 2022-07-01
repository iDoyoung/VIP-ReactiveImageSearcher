//
//  Seeds.swift
//  ReactiveImageSearcher+RxSwiftTests
//
//  Created by Doyoung on 2022/06/30.
//

import XCTest
@testable import ReactiveImageSearcher_RxSwift

struct Seeds {
    
    private init() { }
    
    struct Photos {
        static let imageURL = Photo.ImageURL(raw: "", full: "", regular: "", small: "", thumb: "", small_s3: "")
        static let randomPhoto = Photo(id: "1",
                                       created_at: "2022-06-24T10:10:29-04:00",
                                       updated_at: "2022-06-24T10:10:29-04:00",
                                       promoted_at: "2022-06-24T10:10:29-04:00",
                                       urls: imageURL)
    }
    
    struct MockData {
        static let jsonObject: [String: Any] = [
            "id": "vsqnoClxTc0",
            "created_at": "2022-06-27T19:52:47-04:00",
            "updated_at": "2022-06-29T21:30:03-04:00",
            "promoted_at": "2022-06-28T14:16:01-04:00",
            "urls": [
                "raw": "https://images.unsplash.com/photo-1656373906615-db8d7b15e714?ixid=MnwzMzQ2NTN8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NTY2Mzc3NDg&ixlib=rb-1.2.1",
                "full": "https://images.unsplash.com/photo-1656373906615-db8d7b15e714?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzQ2NTN8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NTY2Mzc3NDg&ixlib=rb-1.2.1&q=80",
                "regular": "https://images.unsplash.com/photo-1656373906615-db8d7b15e714?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQ2NTN8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NTY2Mzc3NDg&ixlib=rb-1.2.1&q=80&w=1080",
                "small": "https://images.unsplash.com/photo-1656373906615-db8d7b15e714?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQ2NTN8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NTY2Mzc3NDg&ixlib=rb-1.2.1&q=80&w=400",
                "thumb": "https://images.unsplash.com/photo-1656373906615-db8d7b15e714?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzQ2NTN8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NTY2Mzc3NDg&ixlib=rb-1.2.1&q=80&w=200",
                "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1656373906615-db8d7b15e714"
            ]
        ]
    }
}
