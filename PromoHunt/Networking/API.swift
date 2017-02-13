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

struct CompaniesFetchRequest: Request, ModelArrayConstructibleResponse {
    typealias Model = Company

    static var path: String = "companies.json"
    static var method: HTTPMethod = .get
    static var version: ApiVersion = .one
    static var parameters: JSONDictionary = [:]
}

struct PromosFetchRequest: Request, ModelArrayConstructibleResponse {
    typealias Model = Promo

    static var path: String = "companies/%d/promos.json"
    static var method: HTTPMethod = .get
    static var version: ApiVersion = .one
    static var parameters: JSONDictionary = [:]

    static func request(for company: Company, completion: @escaping ((ResponseReturn<[Promo]>) -> Void)) {
        let absloutePath = String(format: path, arguments: [company.id])
        request(path: absloutePath, completion: completion)
    }
}

struct PromoVoteRequest: Request  {
    static var path: String = "promos/%d/vote"
    static var method: HTTPMethod = .post
    static var version: ApiVersion = .one
    static var parameters: JSONDictionary = [:]

    static func request(on promo: Promo, vote: Vote, completion: @escaping ((Bool) -> Void)) {
        let absloutePath = String(format: path, promo.id)
        let parameters = self.parameters + ["authentic" : NSNumber(value: vote.authentic)]
        rawRequest(path: absloutePath, parameters: parameters, completion: { completion($0.result.isSuccess) })
    }
}
