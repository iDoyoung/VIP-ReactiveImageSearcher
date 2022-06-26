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
        photoWorker.fetchRandomPhoto { <#Result<Photo, DataTransferError>#> in
            <#code#>
        }
    }
    
}

protocol MainBusinessLogic {
    func fetchRandomPhoto()
}

protocol MainDataStore {
    
}
