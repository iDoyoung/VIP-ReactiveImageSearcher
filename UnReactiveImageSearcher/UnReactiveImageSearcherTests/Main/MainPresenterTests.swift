//
//  MainPresenterTests.swift
//  ReactiveImageSearcherTests
//
//  Created by Doyoung on 2022/06/26.
//

import XCTest
@testable import UnReactiveImageSearcher

class MainPresenterTests: XCTestCase {

    //MARK: - System under test
    var sut: MainPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainPresenter()
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
    
    //MARK: - TestS
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
