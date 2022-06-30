//
//  PhotoWorker.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/06/30.
//

import RxSwift

class PhotoWorker {
    
    var service: DataTransferable
    
    init (service: DataTransferable = DataTransferService(with: NetworkService(configuration: NetworkConfiguration(baseURL: URL(string: "https://api.unsplash.com/")!)))) {
        self.service = service
    }
    
    func fetchRandomPhoto() -> Observable<Photo> {
        let endpoint = APIEndpoint.getRandomPhoto()
        return service.request(with: endpoint)
    }
    
}
