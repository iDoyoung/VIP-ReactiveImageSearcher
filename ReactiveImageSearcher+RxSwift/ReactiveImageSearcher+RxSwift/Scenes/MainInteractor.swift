//
//  MainInteractor.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/07/01.
//

import RxSwift

final class MainInteractor: MainBusinessLogic {
    
    var photoWorker = PhotoWorker()
    var presenter: MainPresentLogic?
    var disposeBag = DisposeBag()
    
    func fetchRandomPhoto() {
        let observable = photoWorker.fetchRandomPhoto()
        presenter?.showSuccessFetchedRandomPhoto(observable)
    }
    
}

protocol MainBusinessLogic {
    func fetchRandomPhoto()
}

