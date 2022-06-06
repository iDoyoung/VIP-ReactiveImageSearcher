//
//  ReactiveImageSearcherTests.swift
//  ReactiveImageSearcherTests
//
//  Created by Doyoung on 2022/05/27.
//

import XCTest
@testable import ReactiveImageSearcher

class NetworkServiceTests: XCTestCase {
    
    //MARK: - Mock
    private struct NetworkConfigurableMock: NetworkConfigurable {
        var baseURL: URL = URL(string: "https://mock.test.com")!
        var headers: [String : String] = [:]
        var queryParameters: [String : String] = [:]
    }
    
    private struct SessionManagerMock: NetworkManager {
        let data: Data?
        let response: HTTPURLResponse?
        let error: Error?
        
        func request(_ request: URLRequest, completion: @escaping CompletionHandler) {
            completion(data, response, error)
        }
    }
    
    struct EndpointMock: Requestable {
        var path: String
        var isFullPath: Bool = false
        var method: HttpMethodType
        var headerParameters: [String : String] = [:]
        var queryParameters: [String : String] = [:]
        var bodyParameters: [String : Any] = [:]
        
        init(path: String, method: HttpMethodType) {
            self.path = path
            self.method = method
        }
    }
    
    private enum NetworkErrorMock: Error {
        case someError
    }
    
    var sut: NetworkService!
    var endpoint: EndpointMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        endpoint = EndpointMock(path: "http://mock.test.com", method: .get)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        endpoint = nil
        try super.tearDownWithError()
    }
    
    func test_shouldResturnResponseWhenPassMockData() {
        //given
        let promise = expectation(description: "Should return correct data")
        let expectedResponseData = "Response data".data(using: .utf8)!
        let sessionManager = SessionManagerMock(data: expectedResponseData,
                                                response: nil, error: nil)
        sut = NetworkService(configuration: NetworkConfigurableMock(), sessionManager: sessionManager)
        //when
        sut.reqeust(endpoint: endpoint) { result in
            guard let responseData = try? result.get() else {
                XCTFail("Should return proper response")
                return
            }
            XCTAssertEqual(responseData, expectedResponseData)
            promise.fulfill()
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    
    func test_shouldReturnCancelledErrorWhenErrorWithNSURLErrorCancelled() {
        //given
        let promise = expectation(description: "Should return hasStatusCode error")
        let cancelledError = NSError(domain: "network", code: NSURLErrorCancelled, userInfo: nil)
        let sessionManager = SessionManagerMock(data: nil,
                                                response: nil,
                                                error: cancelledError as Error)
        sut = NetworkService(configuration: NetworkConfigurableMock(), sessionManager: sessionManager)
        //when
        sut.reqeust(endpoint: endpoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.cancelled = error else {
                    XCTFail("NetworkError.cancelled not found")
                    return
                }
                promise.fulfill()
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    
    func test_shouldReturnGenerationErrorWhenPassMalformedUrl() {
        //given
        let promise = expectation(description: "Should return correct data")
        let expectedResponseData = "Response data".data(using: .utf8)!
        let sessionManager = SessionManagerMock(data: expectedResponseData,
                                                response: nil,
                                                error: nil)
        sut = NetworkService(configuration: NetworkConfigurableMock(), sessionManager: sessionManager)
        endpoint = EndpointMock(path: "~!@#$%", method: .get)
        //when
        sut.reqeust(endpoint: endpoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should throw url generation error")
            } catch let error {
                guard case NetworkError.urlGeneration = error else {
                    XCTFail("NetworkError.urlGeneration not found")
                    return
                }
                promise.fulfill()
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    
    func test_shouldReturnhasStatusCodeErrorWhenStatusCodeEqualOrAbove400() {
        //given
        let promise = expectation(description: "Should return hasStatusCode error")
        let endpoint = EndpointMock(path: "http://mock.test.com", method: .get)
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        let error = NetworkErrorMock.someError
        let sessionManger = SessionManagerMock(data: nil,
                                               response: response,
                                               error: error)
        sut = NetworkService(configuration: NetworkConfigurableMock(), sessionManager: sessionManger)
        //when
        sut.reqeust(endpoint: endpoint) { result in
            do {
                _ = try result.get()
                XCTFail("Shoult not happen")
            } catch let error {
                if case NetworkError.error(let statusCode, _) = error {
                    XCTAssertEqual(statusCode, 500)
                    promise.fulfill()
                }
            }
        }       //then
        wait(for: [promise], timeout: 1)
    }
    
    func test_shouldReturnNotConntedErrorWhenErrorWithNSURLErrorNotConnectedToInternet() {
        //given
        let promise = expectation(description: "Should return hasStatusCode error")
        let endpoint = EndpointMock(path: "http://mock.test.com", method: .get)
        let error = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        let sessionManager = SessionManagerMock(data: nil,
                                                response: nil,
                                                error: error as Error)
        sut = NetworkService(configuration: NetworkConfigurableMock(), sessionManager: sessionManager)
        //when
        sut.reqeust(endpoint: endpoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.notConnected = error else {
                    XCTFail("NetworkError.notConnected not found")
                    return
                }
                promise.fulfill()
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    
}
