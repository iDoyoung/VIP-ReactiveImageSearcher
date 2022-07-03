//
//  Namespace.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/21.
//

import Foundation

enum UnsplashAPI {
    
    enum Path {
        static let randomPhoto = "photos/random"
    }
    
    enum ClientID {
        static let key = "client_id"
        static let value = getClientIDKey()
    }
    
    private static func getClientIDKey() -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID_KEY") as? String else {
            return ""
        }
        return apiKey
    }
    
}
