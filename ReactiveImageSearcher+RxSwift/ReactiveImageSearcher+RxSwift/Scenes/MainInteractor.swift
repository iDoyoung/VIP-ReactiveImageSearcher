//
//  MainInteractor.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/07/01.
//

import Foundation

final class MainInteractor: MainBusinessLogic {
    
    var photoWorker = PhotoWorker()
    var presenter: MainPresentLogic?
    
    func fetchRandomPhoto() {
    }
    
}

protocol MainBusinessLogic {
    func fetchRandomPhoto()
}

