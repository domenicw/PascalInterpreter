//
//  Token+Extensions.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

extension Token: Equatable {
    static public func ==(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.operation(let left), .operation(let right)):
            return left == right
        case (.eof, .eof):
            return true
        case (.integer(let left), .integer(let right)):
            return left == right
        case (.type(let left), .type(let right)):
            return left == right
        case (.type(let val), .integer):
            return val == Type.integer
        case (.integer, .type(let val)):
            return val == Type.integer
        case (.parenthesis(let left), .parenthesis(let right)):
            return left == right
        default:
            return false
        }
    }
}

extension Operation: Equatable {
    static public func ==(lhs: Operation, rhs: Operation) -> Bool {
        switch (lhs, rhs) {
        case (.minus, .minus):
            return true
        case (.plus, .plus):
            return true
        case (.mult, .mult):
            return true
        case (.div, .div):
            return true
        default:
            return false
        }
    }
}

extension Parenthesis: Equatable {
    static public func ==(lhs: Parenthesis, rhs: Parenthesis) -> Bool {
        switch (lhs, rhs) {
        case (.open, .open):
            return true
        case (.close, .close):
            return true
        default:
            return false
        }
    }
}

extension Token: CustomStringConvertible {
    public var description: String {
        switch self {
        case .integer:
            return "INTEGER"
        case .operation(let val):
            return "OPERATION \(val)"
        case .type(let val):
            return "TYPE \(val)"
        case .parenthesis(let val):
            return "PARENTHESIS \(val)"
        case .eof:
            return "EOF"
        }
    }
}

extension Type: CustomStringConvertible {
    public var description: String {
        switch self {
        case .integer:
            return "INTEGER"
        }
    }
}

extension Operation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .minus:
            return "MINUS"
        case .plus:
            return "PLUS"
        case .mult:
            return "MULT"
        case .div:
            return "DIV"
        }
    }
}

extension Parenthesis: CustomStringConvertible {
    public var description: String {
        switch self {
        case .open:
            return "OPEN"
        case .close:
            return "CLOSE"
        }
    }
}
