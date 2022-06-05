//
//  DataTransferService.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/05.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}


