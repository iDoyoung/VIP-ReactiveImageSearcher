//
//  PhotoWorkerTests.swift
//  ReactiveImageSearcher+RxSwiftTests
//
//  Created by Doyoung on 2022/06/30.
//

import XCTest
import RxSwift
@testable import ReactiveImageSearcher_RxSwift

class PhotoWorkerTests: XCTestCase {
    
    //MARK: - Subject under test
    var sut: PhotoWorker!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PhotoWorker(service: DataTransferServiceSpy())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test doubles
    class DataTransferServiceSpy: DataTransferable {
        
        var requestCalled = false
        
        func request<T, E>(with endpoint: E) -> Observable<T> where T : Decodable, T == E.Response, E : ResponseRequestable {
            requestCalled = true
            let data = try! JSONSerialization.data(withJSONObject: Seeds.MockData.jsonObject)
            let result: T = try! JSONDecoder().decode(T.self, from: data)
            return Observable.just(result)
        }
        
        func request<E>(with endpoint: E) -> Observable<Data?> where E : ResponseRequestable {
            requestCalled = true
            return Observable.just(nil)
        }
        
    }
    
    //MARK: - Test
    func test_shouldAskService_whenFetchRandomPhoto() {
        //Given
        let serviceSpy = sut.service as! DataTransferServiceSpy
        //When
        sut.fetchRandomPhoto()
        //Then
        XCTAssert(serviceSpy.requestCalled, "FetchRandomPhoto() should ask to service to fetch")
    }
    
}
