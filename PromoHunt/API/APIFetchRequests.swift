//
//  APIFetchRequests.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

// MARK: - Request
protocol Request {
    static var path: String { get }
    static var method: HTTPMethod { get }
    static var version: ApiVersion { get }
    static var parameters: JSONDictionary { get }
}

extension Request {
    static func rawRequest(path: String = Self.path, parameters: JSONDictionary = [:], completion: @escaping ((HTTPResponse) -> Void)) {
        let mergedParameters = self.parameters + parameters
        let versionedPath = "v\(version.rawValue.description)/\(path)"
        let authorizedRequest = HTTPRequest.authorizedRequest(path: versionedPath, method: method, parameters: mergedParameters)
        HTTPManager.makeRequest(authorizedRequest, withCompletion: completion)
    }
}

// MARK: - ConstructibleResponse
protocol ConstructibleResponse {
    associatedtype Model: ObjectMapping
    associatedtype ReturnType

    static func constructResponse(json: AnyObject) -> ReturnType?
}

extension ConstructibleResponse where Self: Request {
    static func request(path: String = Self.path, parameters: JSONDictionary = [:], completion: @escaping ((ReturnType?) -> Void)) {
        rawRequest(path: path, parameters: parameters) { response in
            DispatchQueue.global().async {

                var result: ReturnType?
                if let json = response.result.value, response.result.isSuccess {
                    result = constructResponse(json: json)
                }

                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}

// MARK: ModelConstructibleResponse
protocol ModelConstructibleResponse: ConstructibleResponse {
    typealias ReturnType = Model
}

extension ModelConstructibleResponse {
    static func constructResponse(json: AnyObject) -> Model? {
        guard let jsonDictionary = json as? JSONDictionary else { return nil }
        return try? Model.init(json: jsonDictionary)
    }
}

// MARK: ModelArrayConstructibleResponse
protocol ModelArrayConstructibleResponse: ConstructibleResponse {
    typealias ReturnType = [Model]
}

extension ModelArrayConstructibleResponse {
    static func constructResponse(json: AnyObject) -> [Model]? {
        guard let jsonArray = json as? [JSONDictionary] else { return nil }
        return jsonArray.flatMap({ try? Model.init(json: $0) })
    }
}
