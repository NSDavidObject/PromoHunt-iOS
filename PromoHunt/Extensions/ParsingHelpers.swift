//
//  ParsingHelpers.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/31/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

enum ParsingError: Error {
    case unexpectedType
}

func UnWrapOptionalValue<InputType, ExpectedType>(_ input: InputType) -> ExpectedType? {
    guard let expectedValue = input as? ExpectedType else {
        return nil
    }
    return expectedValue
}

func UnWrapRequiredValue<InputType, ExpectedType>(_ input: InputType) throws -> ExpectedType {
    guard let expectedValue = input as? ExpectedType else {
        throw ParsingError.unexpectedType
    }
    return expectedValue
}
