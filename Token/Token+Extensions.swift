//
//  Token+Extensions.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

extension Token: CustomStringConvertible {
    var description: String {
        switch self {
        case .integer:
            return "INTEGER"
        case .plus:
            return "PLUS"
        case .eof:
            return "EOF"
        }
    }
}
