//
//  DataTransferServiceTests.swift
//  ReactiveImageSearcherTests
//
//  Created by Doyoung on 2022/06/06.
//

import XCTest
@testable import UnReactiveImageSearcher

class DataTransferServiceTests: XCTestCase {
    
    //MARK: - Mock
    private enum DataTransferErrorMock: Error {
        case someError
    }
    
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
    
    private struct MockModel: Decodable {
        let name: String
    }
    
    var sut: DataTransferService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_shouldDecodeResponse_whenReceivedValidJSONResponse() {
        //given
        let promise = expectation(description: "Should decode mock object")
        let configure = NetworkConfigurableMock()
        let responseData = #"{"name": "MockData"}"#.data(using: .utf8)
        let sessionManager = SessionManagerMock(data: responseData,
                                                response: nil,
                                                error: nil)
        let networkService = NetworkService(configuration: configure, sessionManager: sessionManager)
        sut = DataTransferService(with: networkService)
        
        sut.request(with: EndPoint<MockModel>(path: "https://mock.endpoint.com")) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "MockData")
                promise.fulfill()
            } catch {
               XCTFail("Failed decoding MockObject")
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    
    func test_shouldNotDecodeObject_whenReceivedInvalidResponse() {
        //given
        let promise = expectation(description: "Should not decode mock object")
        let configure = NetworkConfigurableMock()
        let responseData = #"{"title": "MockData"}"#.data(using: .utf8)
        let sessionManager = SessionManagerMock(data: responseData,
                                                response: nil,
                                                error: nil)
        let networkService = NetworkService(configuration: configure, sessionManager: sessionManager)
        sut = DataTransferService(with: networkService)
        //when
        sut.request(with: EndPoint<MockModel>(path: "https://mock.endpoint.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
                promise.fulfill()
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    
    func test_shouldBeNetworkError_whenReceivedBadRequest() {
        //given
        let promise = expectation(description: "Should throw network error")
        let configure = NetworkConfigurableMock()
        let responseData = #"{"title": "MockData"}"#.data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: nil)
        let sessionManger = SessionManagerMock(data: responseData,
                                               response: response,
                                               error: DataTransferErrorMock.someError)
        let networkService = NetworkService(configuration: configure,
                                            sessionManager: sessionManger)
        sut = DataTransferService(with: networkService)
        //when
        sut.request(with: EndPoint<MockModel>(path: "https://mock.endpoind.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case DataTransferError.networkFailure(NetworkError.error(statusCode: 500, _)) = error {
                    promise.fulfill()
                } else {
                    XCTFail("Different error")
                }
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
    
    func test_shouldBeNoDataError_whenReceivedEmptyData() {
        //given
        let promise = expectation(description: "Should throw no data error")
        let configure = NetworkConfigurableMock()
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: nil)
        let sessionManger = SessionManagerMock(data: nil,
                                               response: response,
                                               error: nil)
        let networkService = NetworkService(configuration: configure,
                                            sessionManager: sessionManger)
        sut = DataTransferService(with: networkService)
        //when
        sut.request(with: EndPoint<MockModel>(path: "https://mock.endpoind.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case DataTransferError.noResponse = error {
                    promise.fulfill()
                } else {
                    XCTFail("Different error")
                }
            }
        }
        //then
        wait(for: [promise], timeout: 1)
    }
}
