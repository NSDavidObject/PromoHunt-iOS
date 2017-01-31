//
//  APIFetchRequests.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

protocol FetchRequest {
    associatedtype Model: ObjectMapping
    associatedtype ReturnType

    static var path: String { get }
    static var version: ApiVersion { get }
    static var parameters: JSONDictionary { get }

    static func constructResult(json: AnyObject) -> ReturnType?
}

protocol ModelFetchRequest: FetchRequest {
    typealias ReturnType = Model
}

extension ModelFetchRequest {
    static func constructResult(json: AnyObject) -> Model? {
        guard let jsonDictionary = json as? JSONDictionary else { return nil }
        return try? Model.init(json: jsonDictionary)
    }
}

protocol ModelArrayFetchRequest: FetchRequest {
    typealias ReturnType = [Model]
}

extension ModelArrayFetchRequest {
    static func constructResult(json: AnyObject) -> [Model]? {
        guard let jsonArray = json as? [JSONDictionary] else { return nil }
        return jsonArray.flatMap({ try? Model.init(json: $0) })
    }
}

extension FetchRequest {
    static var versionedPath: String {
        return "v\(version.rawValue.description)/\(path)"
    }
    static func request(with parameters: JSONDictionary = [:], completion: @escaping ((ReturnType?) -> Void)) {
        DispatchQueue.global().async {
            let mergedParameters = self.parameters + parameters
            let authorizedRequest = HTTPRequest.authorizedRequest(path: versionedPath, method: .get, parameters: mergedParameters)
            HTTPManager.makeRequest(authorizedRequest) { response in

                var result: ReturnType?
                if let json = response.result.value, response.result.isSuccess {
                    result = self.constructResult(json: json)
                }

                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
