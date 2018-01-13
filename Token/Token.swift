//
//  Token.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

enum Token {
    case integer(Int)
    case operation(Operation)
    case type(Type)
    case eof
}

enum Type {
    case integer
}

enum Operation {
    case minus
    case plus
}
