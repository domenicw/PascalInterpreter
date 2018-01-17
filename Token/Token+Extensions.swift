//
//  Token+Extensions.swift
//  PascalInterpreter
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
        case (.type(let left), .type(let right)):
            return left == right
        case (.constant(let left), .constant(let right)):
            return left == right
        case (.parenthesis(let left), .parenthesis(let right)):
            return left == right
        case (.program, .program):
            return true
        case (.variable, .variable):
            return true
        case (.begin, .begin):
            return true
        case (.end, .end):
            return true
        case (.dot, .dot):
            return true
        case (.colon, .colon):
            return true
        case (.coma, .coma):
            return true
        case (.id(let left), .id(let right)):
            return left == right
        case (.assign, .assign):
            return true
        case (.semi, .semi):
            return true
        default:
            return false
        }
    }
}

extension Constant: Equatable {
    static public func ==(lhs: Constant, rhs: Constant) -> Bool {
        switch (lhs, rhs) {
        case (.integer(let left), .integer(let right)):
            return left == right
        case (.real(let left), .real(let right)):
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
        case (.integerDiv, .integerDiv):
            return true
        case (.floatDiv, .floatDiv):
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

extension Type: Equatable {
    static public func ==(lhs: Type, rhs: Type) -> Bool {
        switch (lhs, rhs) {
        case (.integer, .integer):
            return true
        case (.real, .real):
            return true
        default:
            return false
        }
    }
}

extension Token: CustomStringConvertible {
    public var description: String {
        switch self {
        case .operation(let val):
            return "OPERATION \(val)"
        case .type(let val):
            return "TYPE \(val)"
        case .constant(let val):
            return "CONSTANT \(val)"
        case .parenthesis(let val):
            return "PARENTHESIS \(val)"
        case .program:
            return "PROGRAM"
        case .variable:
            return "VARIABLE"
        case .begin:
            return "BEGIN"
        case .end:
            return "END"
        case .dot:
            return "DOT"
        case .colon:
            return "COLON"
        case .coma:
            return "COMA"
        case .id:
            return "ID"
        case .assign:
            return "ASSIGN"
        case .semi:
            return "SEMI"
        case .eof:
            return "EOF"
        }
    }
}

extension Constant: CustomStringConvertible {
    public var description: String {
        switch self {
        case .integer:
            return "INTEGER"
        case .real:
            return "REAL"
        }
    }
}

extension Type: CustomStringConvertible {
    public var description: String {
        switch self {
        case .integer:
            return "INTEGER"
        case .real:
            return "REAL"
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
        case .integerDiv, .floatDiv:
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
