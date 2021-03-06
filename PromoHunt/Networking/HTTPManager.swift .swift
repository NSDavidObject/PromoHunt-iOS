//
//  HTTPManager.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/29/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import Alamofire
import CommonUtilities

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct HTTPRequest {
    let urlString: String
    let method: HTTPMethod
    let headers: [String: String]?
    let parameters: JSONDictionary?
}

struct HTTPResponse<T> {
    let rawData: Data?
    let requestURL: String?
    let result: Result<T>
}

class HTTPManager {
    
    static func makeJSONRequest(_ request: HTTPRequest, withCompletion completion: @escaping (HTTPResponse<Any>) -> Void) {
        DispatchQueue.global().async {
            Alamofire.request(request.urlString, method: request.alamofireMethod(), parameters: request.parameters, headers: request.headers).responseJSON { response in
                DispatchQueue.main.async {
                    completion(HTTPResponse(rawData: response.data, requestURL: request.urlString, result: response.result.resultFromAlamofire()))
                }
            }
        }
    }
    
    static func makeDataRequest(_ request: HTTPRequest, withCompletion completion: @escaping (HTTPResponse<Data>) -> Void) {
        DispatchQueue.global().async {
            Alamofire.request(request.urlString, method: request.alamofireMethod(), parameters: request.parameters, headers: request.headers).responseData { response in
                DispatchQueue.main.async {
                    completion(HTTPResponse(rawData: response.data, requestURL: request.urlString, result: response.result.resultFromAlamofire()))
                }
            }
        }
    }
}
