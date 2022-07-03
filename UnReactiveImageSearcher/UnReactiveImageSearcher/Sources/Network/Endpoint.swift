//
//  Endpoint.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/05/28.
//

import Foundation

enum HttpMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum RequestGenerationError: Error {
    case components
}

class EndPoint<R>: ResponseRequestable {
    
    typealias Response = R
    
    let path: String
    let isFullPath: Bool
    let method: HttpMethodType
    let headerParameters: [String: String]
    let queryParameters: [String: String]
    let bodyParameters: [String : Any]
    
    init(path: String,
         isFullPath: Bool = false,
         method: HttpMethodType = .get,
         headerParameters: [String: String] =  [:],
         queryParameters: [String: String] = [:],
         bodyParameters: [String: Any] = [:]) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
    
}

protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HttpMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParameters: [String: String] { get }
    var bodyParameters: [String: Any] { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}


extension Requestable {

    func url(with config: NetworkConfigurable) throws -> URL {
        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)

        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()

        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }

    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders = config.headers
        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }

        if !bodyParameters.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
        }

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders

        return urlRequest
    }
    
}

protocol ResponseRequestable: Requestable {
    associatedtype Response
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
