//
//  MainInteractorTests.swift
//  ReactiveImageSearcherTests
//
//  Created by Doyoung on 2022/06/26.
//

import XCTest
@testable import UnReactiveImageSearcher

class MainInteractorTests: XCTestCase {

    //MARK: - System under test
    var sut: MainInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainInteractor()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    //MARK: - Test doubles
    class PhotoWorkerSpy: PhotoWorker {
            
        var fetchRandomPhotoCalled = false
        var resultIsSuccess = false
        
        override func fetchRandomPhoto(completion: @escaping PhotoWorker.CompletionHandler) {
            fetchRandomPhotoCalled = true
            if resultIsSuccess {
                completion(.success(Seeds.Photos.randomPhoto))
            } else {
                completion(.failure(.noResponse))
            }
        }
        
    }
    
    class MainPresenterSpy: MainPresentLogic {
        
        var showSuccessFetchedRandomPhotoCalled = false
        var showFailureFetchedRandomPhotoCalled = false
        
        func showSuccessFetchedRandomPhoto(_ photo: Photo) {
            showSuccessFetchedRandomPhotoCalled = true
        }
        
        func showFailureFetchedRandomPhoto() {
            showFailureFetchedRandomPhotoCalled = true
        }
        
    }
    
    //MARK: - Tests
    func test_shouldAskPresenterShowSuccessFetchRandomPhotoAndWokerFetchRandomPhotoWhenResultIsSuccessByFetchRandomPhoto() {
        //Given
        let presenter = MainPresenterSpy()
        let worker = PhotoWorkerSpy()
        worker.resultIsSuccess = true
        sut.presenter = presenter
        sut.photoWorker = worker
        //When
        sut.fetchRandomPhoto()
        //Then
        XCTAssert(presenter.showSuccessFetchedRandomPhotoCalled, "Should ask presenter to show success fetch random photo")
        XCTAssert(worker.fetchRandomPhotoCalled, "Should ask worker to fetch random photo")
    }
    
    func test_shouldAskPresenterShowShowFailureFetchedRandomPhotoAndWorkerFetchRandomPhotoCalledWhenResultIsFailureByFetchRandomPhoto() {
        //Given
        let presenter = MainPresenterSpy()
        let worker = PhotoWorkerSpy()
        sut.presenter = presenter
        sut.photoWorker = worker
        //When
        sut.fetchRandomPhoto()
        //Then
        XCTAssert(presenter.showFailureFetchedRandomPhotoCalled, "Should ask presenter to show failure fetch random photo")
        XCTAssert(worker.fetchRandomPhotoCalled, "Should ask worker to fetch random photo")
    }
    
}
