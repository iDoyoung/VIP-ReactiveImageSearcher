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
    
    func showSuccessFetchedRandomPhoto(_ photo: Photo) {
        viewController?.displayRandomPhoto(photo)
    }
    
    func showFailureFetchedRandomPhoto() {
        viewController?.displayFailureFetchingAlert()
    }
    
}

protocol MainPresentLogic {
    func showSuccessFetchedRandomPhoto(_ photo: Photo)
    func showFailureFetchedRandomPhoto()
}
