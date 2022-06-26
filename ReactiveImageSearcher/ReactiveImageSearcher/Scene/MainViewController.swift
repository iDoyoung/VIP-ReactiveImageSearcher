//
//  ViewController.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/05/27.
//

import UIKit

class MainViewController: UIViewController {

    var interactor: MainInteractor?
    
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Life cycle
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
        // Do any additional setup after loading the view.
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
    }
    
    //MARK: - Fetch photo
    func fetchRandomPhoto() {
        interactor?.fetchRandomPhoto()
    }
    
}

extension MainViewController: MainDisplayLogic {
    func displayRandomPhoto() {
    }
    
    func displayFailureFetchingAlert() {
    }
    
}

protocol MainDisplayLogic: AnyObject {
    func displayRandomPhoto()
    func displayFailureFetchingAlert()
}
