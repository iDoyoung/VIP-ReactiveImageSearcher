//
//  MainPresenter.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/25.
//

import UIKit

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
