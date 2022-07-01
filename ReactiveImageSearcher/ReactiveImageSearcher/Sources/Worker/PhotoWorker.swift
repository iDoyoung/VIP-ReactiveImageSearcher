//
//  PhotoWorker.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/07.
//

import Foundation

protocol PhotoStorable {
    func fetchRandomPhoto()
}
class PhotoWorker {
    
    typealias CompletionHandler = (Result<Photo, DataTransferError>) -> Void
    var service: DataTransferable
    
    init (service: DataTransferable = DataTransferService(with: NetworkService(configuration: NetworkConfiguration(baseURL: URL(string: "https://api.unsplash.com/")!)))) {
        self.service = service
    }
    
    func fetchRandomPhoto(completion: @escaping CompletionHandler) {
        let endpoint = APIEndpoint.getRandomPhoto()
        service.request(with: endpoint, completion: completion)
    }
    
}
