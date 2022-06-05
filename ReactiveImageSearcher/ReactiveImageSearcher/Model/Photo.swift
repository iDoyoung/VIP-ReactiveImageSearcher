//
//  Photo.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/05.
//

import Foundation

struct Photo {
    let id: String
    let created_at: String
    let updated_at: String
    let promoted_at: String
    
    struct imageURL {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
        let small_s3: String
    }
}
