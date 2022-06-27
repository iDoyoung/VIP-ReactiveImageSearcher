//
//  CashManager.swift
//  ReactiveImageSearcher
//
//  Created by Doyoung on 2022/06/26.
//

import UIKit

class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() { }
}
