//
//  CacheManager.swift
//  ReactiveImageSearcher+RxSwift
//
//  Created by Doyoung on 2022/06/30.
//

import UIKit

class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() { }
}
