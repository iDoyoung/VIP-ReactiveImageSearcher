//
//  DataTransferService.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/05.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

protocol DataTransferErrorResolvable {
    func resolve(error: NetworkError) -> Error
}

protocol DataTransferable {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    ///  Handle T type resource data when success request
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) where E.Response == T
    
    /// Handle any data when success request
    func request<E: ResponseRequestable>(with endpoint: E,
                                         completion: @escaping CompletionHandler<Void>) where E.Response == Void
}

class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

class DataTransferErrorResolver: DataTransferErrorResolvable {
    public init() { }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

final class DataTransferService: DataTransferable {
    
    private let networkService: NetworkServicing
    private let errorResolver: DataTransferErrorResolvable
    
    init(with networkService: NetworkServicing, errorResolver: DataTransferErrorResolvable = DataTransferErrorResolver()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
    }
    
    func request<T, E>(with endpoint: E, completion: @escaping CompletionHandler<T>) where T : Decodable, T == E.Response, E : ResponseRequestable {
        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            case .failure(let error):
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
            
    func request<E>(with endpoint: E, completion: @escaping CompletionHandler<Void>) where E : ResponseRequestable, E.Response == Void {
        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            case .failure(let error):
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder = JSONResponseDecoder()) -> Result<T, DataTransferError> {
        do {
            guard let data = data else {
                return .failure(.noResponse)
            }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
    
}
