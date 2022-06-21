//
//  APIEndpoint.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/06.
//

import Foundation

struct APIEndpoint {
   
    static func getRandomPhoto() -> EndPoint<Photo> {
        return EndPoint(path: UnsplashAPI.Path.randomPhoto,
                        queryParameters: [UnsplashAPI.ClientID.key: UnsplashAPI.ClientID.value])
    }
    
}
