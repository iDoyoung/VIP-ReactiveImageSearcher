//
//  APIEndpoint.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/06.
//

import Foundation

struct APIEndpoint {
   
    static func getRandomPhoto() -> EndPoint<Photo> {
        let key = getClientIDKey()
        return EndPoint(path: "photos/random",
                        queryParameters: ["client_id": key])
    }
    
    private static func getClientIDKey() -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID_KEY") as? String else {
            return ""
        }
        return apiKey
    }
    
}
