//
//  ViewController.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/05/27.
//

import UIKit

class MainViewController: UIViewController {

    var interactor: MainBusinessLogic?
    
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - VC Life cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupViewController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRandomPhoto()
    }
    
    func setupViewController() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    //MARK: Fetch
    func fetchRandomPhoto() {
        interactor?.fetchRandomPhoto()
    }

}

extension MainViewController: MainDisplayLogic {
    
    func displayRandomPhoto(_ photo: Photo) {
        imageView.loadImage(url: photo.urls.full)
    }
    
    func displayFailureFetchingAlert() {
        print("Error")
    }
    
}

protocol MainDisplayLogic: AnyObject {
    func displayRandomPhoto(_ photo: Photo)
    func displayFailureFetchingAlert()
}
