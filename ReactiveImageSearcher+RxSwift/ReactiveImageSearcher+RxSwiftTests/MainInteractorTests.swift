//
//  MainInteractorTests.swift
//  ReactiveImageSearcher+RxSwiftTests
//
//  Created by Doyoung on 2022/07/01.
//

import XCTest
import RxSwift
@testable import ReactiveImageSearcher_RxSwift

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
    
    //MARK: - Test Doubles
    class PhotoWorkerSpy: PhotoWorker {
            
        var fetchRandomPhotoCalled = false
        var resultIsSuccess = false
        
        override func fetchRandomPhoto() -> Observable<Photo> {
            fetchRandomPhotoCalled = true
            return Observable.just(Seeds.Photos.randomPhoto)
        }
    }
    
    class MainPresenterSpy: MainPresentLogic {
        
        var showSuccessFetchedRandomPhotoCalled = false
        var showFailureFetchedRandomPhotoCalled = false
        
        func showSuccessFetchedRandomPhoto(_ obeservable: Observable<Photo>) {
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
        sut.presenter = presenter
        sut.photoWorker = worker
        //When
        sut.fetchRandomPhoto()
        //Then
        XCTAssert(presenter.showSuccessFetchedRandomPhotoCalled, "Should ask presenter to show success fetch random photo")
        XCTAssert(worker.fetchRandomPhotoCalled, "Should ask worker to fetch random photo")
    }
    
}
