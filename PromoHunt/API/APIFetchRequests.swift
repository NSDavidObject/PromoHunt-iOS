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
    static var parameters: [String : AnyObject] { get }

    static func constructResult(json: AnyObject) -> ReturnType?
}

protocol ModelFetchRequest: FetchRequest {
    typealias ReturnType = Model
}

extension ModelFetchRequest {
    static func constructResult(json: AnyObject) -> Model? {
        guard let jsonDictionary = json as? [String:AnyObject] else { return nil }
        return Model.init(json: jsonDictionary)
    }
}

protocol ModelArrayFetchRequest: FetchRequest {
    typealias ReturnType = [Model]
}

extension ModelArrayFetchRequest {
    static func constructResult(json: AnyObject) -> [Model]? {
        guard let jsonArray = json as? [[String:AnyObject]] else { return nil }
        return jsonArray.flatMap({ Model.init(json: $0) })
    }
}

extension FetchRequest {
    static var versionedPath: String {
        return "v\(version.rawValue.description)/\(path)"
    }
    static func request(completion: @escaping ((ReturnType?) -> Void)) {
        DispatchQueue.global().async {
            let authorizedRequest = HTTPRequest.authorizedRequest(path: versionedPath, method: .get, parameters: parameters)
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
