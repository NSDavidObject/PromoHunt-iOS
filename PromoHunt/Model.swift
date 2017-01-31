//
//  Model.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/29/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

protocol ObjectMapping {
    init(json: JSONDictionary) throws
}
