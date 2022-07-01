//
//  NetworkConfiguration.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/06/28.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct NetworkConfiguration: NetworkConfigurable {
    let baseURL: URL
    let headers: [String: String]
    let queryParameters: [String: String]
    
    init(baseURL: URL,
         headers: [String: String] = [:],
         queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
