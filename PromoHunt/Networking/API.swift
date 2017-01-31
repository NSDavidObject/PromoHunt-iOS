//
//  API.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/29/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

enum ApiVersion: Int {
    case one = 1
}

struct CompaniesFetchRequest: ModelArrayFetchRequest {
    typealias Model = Company
    
    static var path: String = "companies.json"
    static var version: ApiVersion = .one
    static var parameters: JSONDictionary = [:]
}
