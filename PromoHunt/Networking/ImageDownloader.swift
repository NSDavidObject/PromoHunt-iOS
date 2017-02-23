//
//  ImageDownloader.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/12/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import Alamofire

class ImageDownloader {
    
    private init() {}
    static func download(imageForUrl url: URL, withCompletion completion: @escaping (RequestResult<UIImage>) -> Void) {
        let request = HTTPRequest(urlString: url.absoluteString, method: .get, headers: nil, parameters: nil)
        HTTPManager.makeDataRequest(request) { response in
            guard let rawData = response.result.value, response.result.isSuccess, let image = UIImage(data: rawData) else {
                completion(.error)
                return
            }
            completion(.value(image))
        }
    }
}
