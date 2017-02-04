//
//  Company.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct Company: ObjectMapping {
    let id: UInt64
    let name: String
    let color: String
    let image: String
    let promoted: Bool

    init(json: JSONDictionary) throws {
        self.id = try UnWrapRequiredValue(json["id"])
        self.name = try UnWrapRequiredValue(json["name"])
        self.color = try UnWrapRequiredValue(json["color"])
        self.image = try UnWrapRequiredValue(json["image"])
        self.promoted = Bool(try UnWrapRequiredValue(json["promoted"]) as NSNumber)
    }
}
