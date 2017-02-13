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

class ImageManager {
    
    private init() {}
    
    static func image(forURL url: URL, usingCache cacheUsability: CacheUsability<ImageCache> = .cache(ImageCache.shared), completion: @escaping ((ResponseReturn<(url: URL, image: UIImage)>) -> Void)) {
        let cache = cacheUsability.cache
        if let cachedImage = cache?[url] {
            completion(.value((url: url, image: cachedImage)))
        } else {
            ImageDownloader.download(imageForUrl: url) { response in
                guard let image = response.value else {
                    completion(.error)
                    return
                }
                
                cache?[url] = image
                completion(.value((url: url, image: image)))
            }
        }
    }
}
