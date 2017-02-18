//
//  Company.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import CommonUtilities

struct Company: ObjectMapping {
    let id: UInt64
    let name: String
    let imageURL: URL
    let color: UIColor
    let promoted: Bool

    init(json: JSONDictionary) throws {
        self.id = try UnWrapRequiredValue(json["id"])
        self.name = try UnWrapRequiredValue(json["name"])
        self.promoted = Bool(try UnWrapRequiredValue(json["promoted"]) as NSNumber)
        
        let imageURLString: String = try UnWrapRequiredValue(json["image"])
        self.imageURL = try UnWrapRequiredValue(URL(string: imageURLString))
        
        let colorHex: String = try UnWrapRequiredValue(json["color"])
        self.color = UIColor(hex: colorHex)
    }
}

extension Company: Hashable {

    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: Company, rhs: Company) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.imageURL == rhs.imageURL && lhs.color == rhs.color
    }
}
