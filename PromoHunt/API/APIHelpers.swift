//
//  APIHelpers.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

private struct Constants {
    static let Host = "https://peaceful-island-42708.herokuapp.com/api/"
}

extension HTTPRequest {
    static func authorizedRequest(path: String, method: HTTPMethod = .get, parameters: JSONDictionary = [:]) -> HTTPRequest {
        let headers = ["Authorization" : "\(Secrets.APIKey)", "Accept": "application/json"]
        let urlString = Constants.Host + path

        var authorizedParameters = parameters
        authorizedParameters["auth_token"] = "e0c6787c-e67b-11e6-bf01-fe55135034f3" as AnyObject?
        return HTTPRequest(urlString: urlString, method: method, headers: headers, parameters: authorizedParameters)
    }
}
