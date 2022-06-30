//
//  APIEndpoint.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/06/30.
//

import Foundation

struct APIEndpoint {
   
    static func getRandomPhoto() -> EndPoint<Photo> {
        return EndPoint<Photo>(path: UnsplashAPI.Path.randomPhoto,
                        queryParameters: [UnsplashAPI.ClientID.key: UnsplashAPI.ClientID.value])
    }
    
}
