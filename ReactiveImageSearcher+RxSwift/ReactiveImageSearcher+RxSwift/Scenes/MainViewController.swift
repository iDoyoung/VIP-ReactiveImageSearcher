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
        setUpViewController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setupViewController() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
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
    func displatRandomPhoto(_ photo: Photo)
    func displayFailureFetchingAlert()
}
