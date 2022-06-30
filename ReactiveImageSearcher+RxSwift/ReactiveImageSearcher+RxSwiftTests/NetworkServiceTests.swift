//
//  NetworkServiceTests.swift
//  ReactiveImageSearcher+RxSwiftTests
//
//  Created by Doyoung on 2022/06/29.
//

import XCTest
import RxSwift
import RxBlocking
@testable import ReactiveImageSearcher_RxSwift

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
    
    //MARK: System under test
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
    
    //MARK: - Test
    func test_shouldResturnResponseWhenPassMockData() {
        //given
        let expectedResponseData = "Response data".data(using: .utf8)!
        let sessionManager = SessionManagerMock(data: expectedResponseData,
                                                response: nil, error: nil)
        sut = NetworkService(configuration: NetworkConfigurableMock(), sessionManager: sessionManager)
        //when
        let observable = sut.request(endpoint: endpoint).toBlocking(timeout: 1)
        //then
        let value = try! observable.first()
        XCTAssertEqual(value, expectedResponseData)
    }
    
}
