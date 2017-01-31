//
//  Company.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct Company: ObjectMapping {
    let name: String
    init?(json: [String : AnyObject]) {
        guard let name = json["name"] as? String else { return nil }
        self.name = name
    }
}
