//
//  Number.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum Number: AST {
    case integer(Int)
    case real(Float)
}

extension Number: Equatable {
    public static func ==(lhs: Number, rhs: Number) -> Bool {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return left == right
        case let (.real(left), .real(right)):
            return left == right
        default:
            return false
        }
    }
}

extension Number {
    public static prefix func -(number: Number) -> Number {
        switch number {
        case let .integer(value):
            return .integer(-value)
        case let .real(value):
            return .real(-value)
        }
    }
    
    public static prefix func +(number: Number) -> Number {
        return number
    }
    
    public static func +(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return .integer(left + right)
        case let (.real(left), .real(right)):
            return .real(left + right)
        case let (.integer(left), .real(right)):
            return .real(Float(left) + right)
        case let (.real(left), .integer(right)):
            return .real(left + Float(right))
        }
    }
    
    public static func -(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return .integer(left - right)
        case let (.real(left), .real(right)):
            return .real(left - right)
        case let (.integer(left), .real(right)):
            return .real(Float(left) - right)
        case let (.real(left), .integer(right)):
            return .real(left - Float(right))
        }
    }
    
    public static func *(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return .integer(left * right)
        case let (.real(left), .real(right)):
            return .real(left * right)
        case let (.integer(left), .real(right)):
            return .real(Float(left) * right)
        case let (.real(left), .integer(right)):
            return .real(left * Float(right))
        }
    }
    
    public static func /(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return .real(Float(left) / Float(right))
        case let (.real(left), .real(right)):
            return .real(left / right)
        case let (.integer(left), .real(right)):
            return .real(Float(left) / right)
        case let (.real(left), .integer(right)):
            return .real(left / Float(right))
        }
    }
    
    public static func ||(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return .integer(left / right)
        default:
            fatalError("Error: can't div non integer numbers")
        }
    }
}
