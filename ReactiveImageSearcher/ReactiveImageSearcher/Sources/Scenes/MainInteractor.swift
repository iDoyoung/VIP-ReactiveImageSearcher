//
//  MainInteractor.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/22.
//

import Foundation


final class MainInteractor: MainBusinessLogic, MainDataStore {
    
    var presenter: MainPresentLogic?
    var photoWorker = PhotoWorker()
    
    func fetchRandomPhoto() {
        photoWorker.fetchRandomPhoto { [weak self] result in
            switch result {
            case .success(let photo):
                self?.presenter?.showSuccessFetchedRandomPhoto(photo)
            case .failure(let error):
                //TODO: Handler each error
                self?.presenter?.showFailureFetchedRandomPhoto()
            }
        }
   }
    
}

protocol MainBusinessLogic {
    func fetchRandomPhoto()
}

protocol MainDataStore {
    
}
