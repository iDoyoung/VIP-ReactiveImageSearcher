//
//  UnsplashPhoto.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/04.
//

import Foundation

struct UnsplashPhoto {
    let id: String
    let created_at: String
    let updated_at: String
    let promoted_at: String
    let urls: URLs
    let likes: Int
    
    struct URLs {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
        let small_s3: String
    }
    
}
