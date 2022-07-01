//
//  Photo.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/06/30.
//

import Foundation

struct Photo: Decodable, Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let created_at: String
    let updated_at: String
    let promoted_at: String
    let urls: ImageURL
    
    struct ImageURL: Decodable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
        let small_s3: String
    }
}
