//
//  DictionaryHelpers.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/31/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

func +<K, V> (left: [K : V], right: [K : V]) -> [K : V] {
    var result = left
    for (k, v) in right {
        result.updateValue(v, forKey: k)
    }
    return result
}
