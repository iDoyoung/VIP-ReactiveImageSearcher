//
//  NetworkService.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/06/28.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

final class NetworkService: NetworkServicing {
    
    let configuration: NetworkConfigurable
    let sessionManager: NetworkManager
    
    init(configuration: NetworkConfigurable,
         sessionManager: NetworkManager = DefaultNetworkSessionManager()) {
        self.configuration = configuration
        self.sessionManager = sessionManager
    }
    
    func request(endpoint: Requestable) -> Observable<Data?> {
        return Observable.create { [weak self] observer in
            if let self = self {
                do {
                    let urlReqeust = try endpoint.urlRequest(with: self.configuration)
                    self.sessionManager.request(urlReqeust) { data, response, reqeustError in
                        if let requestError = reqeustError {
                            var error: NetworkError
                            if let response = response as? HTTPURLResponse {
                                error = .error(statusCode: response.statusCode, data: data)
                            } else {
                                error = self.resolve(error: requestError)
                            }
                            observer.onError(error)
                        } else {
                            observer.onNext(data)
                        }
                    }
                } catch {
                    let error: NetworkError = .urlGeneration
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
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

final class DefaultNetworkSessionManager: NetworkManager {
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

protocol NetworkServicing {
    func request(endpoint: Requestable) -> Observable<Data?>
}

protocol NetworkManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest, completion: @escaping CompletionHandler)
}
