//
//  ImageManager.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/12/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

enum CacheUsability<T> {
    case none
    case cache(T)
    
    var cache: T? {
        switch self {
        case .none:
            return nil
        case .cache(let value):
            return value
        }
    }
}

enum CachableResult<T> {
    case download(T)
    case memory(T)
    case error
    
    var value: T? {
        switch self {
        case .download(let value): return value
        case .memory(let value): return value
        case .error: return nil
        }
    }
    
    var fromCache: Bool {
        switch self {
        case .download: return false
        case .memory: return true
        case .error: return false
        }
    }
}

class ImageManager {
    
    private init() {}
    
    static func image(forURL url: URL, usingCache cacheUsability: CacheUsability<ImageCache> = .cache(ImageCache.shared), completion: @escaping ((CachableResult<(url: URL, image: UIImage)>) -> Void)) {
        let cache = cacheUsability.cache
        if let cachedImage = cache?[url] {
            completion(.memory((url: url, image: cachedImage)))
        } else {
            ImageDownloader.download(imageForUrl: url) { response in
                guard let image = response.value else {
                    completion(.error)
                    return
                }
                
                cache?[url] = image
                completion(.download((url: url, image: image)))
            }
        }
    }
}

