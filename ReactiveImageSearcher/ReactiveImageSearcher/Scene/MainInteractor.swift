//
//  MainInteractor.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/22.
//

import Foundation


final class MainInteractor: MainBusinessLogic, MainDataStore {
    
    var photoWorker = PhotoWorker()
    
    func fetchRandomPhoto() {
        
    }
    
}

protocol MainBusinessLogic {
    func fetchRandomPhoto()
}

protocol MainDataStore {
    
}
