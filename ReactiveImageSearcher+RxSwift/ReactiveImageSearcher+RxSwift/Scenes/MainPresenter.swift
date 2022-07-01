//
//  MainPresenter.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/07/01.
//

import UIKit
import RxSwift

final class MainPresenter: MainPresentLogic {
    
    weak var viewController: MainDisplayLogic?
    
    func showSuccessFetchedRandomPhoto(_ observable: Observable<Photo>) {
        //viewController?.displatRandomPhoto(<#T##photo: Photo##Photo#>)
    }
    
    func showFailureFetchedRandomPhoto() {
        viewController?.displayFailureFetchingAlert()
    }
    
}

protocol MainPresentLogic {
    func showSuccessFetchedRandomPhoto(_ obeservable: Observable<Photo>)
    func showFailureFetchedRandomPhoto()
}
