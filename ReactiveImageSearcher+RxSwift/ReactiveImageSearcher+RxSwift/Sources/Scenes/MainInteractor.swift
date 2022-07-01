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
        observable.subscribe { [weak self] photo in
            self?.presenter?.showSuccessFetchedRandomPhoto(photo)
        } onError: { error in
            
        }.disposed(by: disposeBag)
    }
    
}

protocol MainBusinessLogic {
    func fetchRandomPhoto()
}

