//
//  ViewController.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/05/27.
//

import UIKit

class ViewController: UIViewController {

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
    
    func setupViewController() {
        let viewController = self
        let interactor = MainInteractor()
        viewController.interactor = interactor
        
    }

}

extension ViewController: MainDisplayLogic {
    func displayRandomPhoto() {
        
    }
}

protocol MainDisplayLogic: AnyObject {
    func displayRandomPhoto()
}
