//
//  ImageCache.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/12/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class MemoryCache<K: Hashable,V> {
    typealias Key = K
    typealias Value = V
    
    private var dictionary = [K:V]()
    
    subscript(_ key: Key) -> Value? {
        get {
            return dictionary[key]
        }
        set(newValue) {
            dictionary[key] = newValue
        }
    }
}

class ImageCache: MemoryCache<URL, UIImage> {
    static let shared = ImageCache()
}
