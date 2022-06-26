//
//  MainPresenter.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/25.
//

import UIKit

final class MainPresenter: MainPresentLogic {
    
    weak var viewControlelr: MainDisplayLogic?
    
    func showFetchedRandomPhotoSuccess() {
        viewControlelr?.displayRandomPhoto()
    }
    
}

protocol MainPresentLogic {
    func showFetchedRandomPhotoSuccess()
}
