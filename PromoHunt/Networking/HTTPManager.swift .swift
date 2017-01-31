//
//  HTTPManager.swift .swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/29/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String:AnyObject]

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

struct HTTPResponse {
    let rawData: Data?
    let requestURL: String?
    let result: Result<AnyObject>
}

class HTTPManager {
    class func makeRequest(_ request: HTTPRequest, withCompletion completion: @escaping (HTTPResponse) -> Void) {
        Alamofire.request(request.urlString, method: request.alamofireMethod(), parameters: request.parameters, headers: request.headers).responseJSON { response in
            completion(HTTPResponse(rawData: response.data, requestURL: request.urlString, result: response.result.resultFromAlamofire()))
        }
    }
}
