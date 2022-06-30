//
//  DataTransferService.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/06/30.
//

import RxSwift

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

final class DataTransferService {
    
    private let networkService: NetworkServicing
    private let errorResolver: DataTransferErrorResolvable
    private var disposeBag = DisposeBag()
    
    init(with networkService: NetworkServicing, errorResolver: DataTransferErrorResolvable = DataTransferErrorResolver()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
    }
    
    func request<T, E>(with endpoint: E) -> Observable<T> where T: Decodable, T == E.Response, E: ResponseRequestable  {
        return networkService.request(endpoint: endpoint)
            .map { data in
                let result: T = try self.decode(data: data)
                return result
            }
    }
    
    func request<E>(with endpoint: E) -> Observable<Data?> where E: ResponseRequestable {
        let result = networkService.request(endpoint: endpoint)
        return result
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder = JSONResponseDecoder()) throws -> T {
        do {
            guard let data = data else {
                throw DataTransferError.noResponse
            }
            let result: T = try decoder.decode(data)
            return result
        } catch {
            throw DataTransferError.parsing(error)
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
    
}
