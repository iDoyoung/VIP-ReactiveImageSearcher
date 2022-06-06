//
//  NetworkService.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/05/30.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

protocol NetworkServicing {
    func reqeust(endpoint: Requestable, completion: @escaping (Result<Data?, NetworkError>) -> Void)
}

protocol NetworkManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest, completion: @escaping CompletionHandler)
}

final class NetworkService: NetworkServicing {
    
    let configuration: NetworkConfigurable
    let sessionManager: NetworkManager
    
    init(configuration: NetworkConfigurable,
         sessionManager: NetworkManager) {
        self.configuration = configuration
        self.sessionManager = sessionManager
    }
    
    func reqeust(endpoint: Requestable, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        do {
            let urlReqeust = try endpoint.urlRequest(with: configuration)
            sessionManager.request(urlReqeust) { data, response, requestError in
                if let requestError = requestError {
                    var error: NetworkError
                    if let response = response as? HTTPURLResponse {
                        error = .error(statusCode: response.statusCode, data: data)
                    } else {
                        error = self.resolve(error: requestError)
                    }
                    completion(.failure(error))
                } else {
                    completion(.success(data))
                }
            }
        } catch {
            completion(.failure(.urlGeneration))
        }
    }
    
    private func request(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) -> URLSessionDataTask {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, requestError in
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                completion(.failure(error))
            } else {
                completion(.success(data))
            }
        }
        return dataTask
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
    
}
