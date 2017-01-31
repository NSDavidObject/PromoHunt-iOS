//
//  HTTPManager+Alamofire.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/29/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import Alamofire

extension HTTPRequest {
    func alamofireMethod() -> Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod(rawValue: method.rawValue)!
    }
}

extension Alamofire.Result {
    func resultFromAlamofire() -> Result<AnyObject>  {
        switch self {
        case .success(let value):
            return Result.success(value as AnyObject)
        case .failure(let error):
            return .failure(error as NSError)
        }
    }
}

/*
 * Copied from Almofile.
 */
public enum Result<Value> {
    case success(Value)
    case failure(Error)

    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }

    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
