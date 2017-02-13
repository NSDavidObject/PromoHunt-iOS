//
//  Promo.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/31/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import CommonUtilities

enum Vote: Int {
    case none = 0
    case valid = 1
    case invalid = -1

    var authentic: Bool {
        switch self {
        case .none: fatalError()
        case .valid: return true
        case .invalid: return false
        }
    }
}

struct Promo: ObjectMapping {
    let id: UInt64
    let code: String
    let userVote: Vote
    let authenticity: Int

    init(json: JSONDictionary) throws {
        self.id = try UnWrapRequiredValue(json["id"])
        self.code = try UnWrapRequiredValue(json["code"])
        self.authenticity = try UnWrapRequiredValue(json["authenticity"])

        let voteRawValue: Int = try UnWrapRequiredValue(json["user_vote"])
        guard let userVote = Vote(rawValue: voteRawValue) else { throw ParsingError.unexpectedValue }
        self.userVote = userVote
    }
}

extension Promo: CustomDebugStringConvertible {
    var debugDescription: String {
        return "(\(code), votes: \(authenticity), user_vote: \(userVote))"
    }
}
