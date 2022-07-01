//
//  MainPresenterTests.swift
//  ReactiveImageSearcher+RxSwiftTests
//
//  Created by Doyoung on 2022/07/01.
//

import XCTest
@testable import ReactiveImageSearcher_RxSwift

class MainPresenterTests: XCTestCase {

    //MARK: - System under test
    var sut: MainPresenter!
    
    override func setUpWithError() throws {
        sut = MainPresenter()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test doubles
    class MainDisplayLogicSpy: MainDisplayLogic {
        
        var displayRandomPhotoCalled = false
        var displayFailureFetchingAlertCalled = false
        
        func displayRandomPhoto(_ photo: Photo) {
            displayRandomPhotoCalled = true
        }
        
        func displayFailureFetchingAlert() {
            displayFailureFetchingAlertCalled = true
        }
        
    }
    
    //MARK: - Test
    func test_shouldCallDisplayRandomPhotoWhenShowSuccessFetchedRandomPhoto() {
        //Given
        let mainDisplayLogic = MainDisplayLogicSpy()
        sut.viewController = mainDisplayLogic
        //When
        let photo = Seeds.Photos.randomPhoto
        sut.showSuccessFetchedRandomPhoto(photo)
        //Then
        XCTAssert(mainDisplayLogic.displayRandomPhotoCalled, "Display random photo")
    }
    
    func test_shouldCallDisplayFailureFetchingAlertWhenShowFailureFetchedRandomPhoto() {
        //Given
        let mainDisplayLogic = MainDisplayLogicSpy()
        sut.viewController = mainDisplayLogic
        //When
        sut.showFailureFetchedRandomPhoto()
        //Then
        XCTAssert(mainDisplayLogic.displayFailureFetchingAlertCalled, "Display Failure Fetching Alert")
    }
    
    

}
