//
//  MainViewcontrollerTests.swift
//  ReactiveImageSearcher+RxSwiftTests
//
//  Created by Doyoung on 2022/07/01.
//

import XCTest
@testable import ReactiveImageSearcher_RxSwift

class MainViewcontrollerTests: XCTestCase {

    //MARK: - System under test
    var sut: MainViewController!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        window = UIWindow()
        setUpViewController()
    }

    override func tearDownWithError() throws {
        window = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func setUpViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
    }

    
    func loadView() {
      window.addSubview(sut.view)
    }
    
    //MARK: - Test doubles
    class MainBusinessLogicSpy: MainBusinessLogic {
        
        var fetchRandomPhotoCalled = false
        
        func fetchRandomPhoto() {
            fetchRandomPhotoCalled = true
        }
        
    }
    
    //MARK: Tests
    func test_shouldDisplayFetchedRandomPhotoWhenViewWillAppear() {
        //Given
        let mainBussiendLogic = MainBusinessLogicSpy()
        sut.interactor = mainBussiendLogic
        loadView()
        //When
        sut.viewWillAppear(true)
        //Then
        XCTAssert(mainBussiendLogic.fetchRandomPhotoCalled, "Should fetch random photo right after the view will appear")
    }

}
