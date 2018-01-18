//
//  Number+Extensions.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 18.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

extension Number: CustomStringConvertible {
    public var description: String {
        switch self {
        case .integer(let val):
            return "INTEGER \(val)"
        case .real(let val):
            return "REAL \(val)"
        }
    }
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
    // Unary minus Number
    public static prefix func -(number: Number) -> Number {
        switch number {
        case let .integer(value):
            return .integer(-value)
        case let .real(value):
            return .real(-value)
        }
    }
    
    // Unary plus number
    public static prefix func +(number: Number) -> Number {
        return number
    }
    
    // Plus operation between two Numbers
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
    
    // Minus operation between two Numbers
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
    
    // Multiplication operation between two Numbers
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
    
    // Float division operation between two Numbers
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
    
    // Integer division operation between two Numbers
    public static func ||(lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return .integer(left / right)
        default:
            fatalError("Error: can't div non integer numbers")
        }
    }
}
