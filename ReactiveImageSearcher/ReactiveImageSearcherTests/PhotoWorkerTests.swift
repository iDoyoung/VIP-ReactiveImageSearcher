//
//  PhotoWorkerTests.swift
//  ReactiveImageSearcherTests
//
//  Created by Doyoung on 2022/06/23.
//

import XCTest
@testable import ReactiveImageSearcher

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
        
        func request<T, E>(with endpoint: E, completion: @escaping CompletionHandler<T>) where T : Decodable, T == E.Response, E : ResponseRequestable {
            requestCalled = true
        }
        
        func request<E>(with endpoint: E, completion: @escaping CompletionHandler<Void>) where E : ResponseRequestable, E.Response == Void {
            requestCalled = true
        }
        
    }
    
    //MARK: - Test
    func test_shouldAskService_whenFetchRandomPhoto() {
        //Given
        let serviceSpy = sut.service as! DataTransferServiceSpy
        //When
        sut.fetchRandomPhoto {  _ in }
        //Then
        XCTAssert(serviceSpy.requestCalled, "FetchRandomPhoto() should ask to service to fetch")
    }
    
}
