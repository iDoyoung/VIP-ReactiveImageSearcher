//
//  NetworkConfig.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/05/29.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}
