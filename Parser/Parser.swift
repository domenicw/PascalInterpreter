//
//  Parser.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Parser {
    
    // Parser Lexer
    private let lexer: Lexer
    // Current token
    private var currentToken: Token
    
    /**
     Initializer for Interpreter class
     
     - Parameter text: Input which needs to be calculated
     
     */
    public init(_ text: String) {
        self.lexer = Lexer(text)
        self.currentToken = self.lexer.nextToken()
    }
    
    /**
     Eats the current character
     
     - Parameter token: Type of Token that should be eaten
     
     */
    private func eat(_ token: Token) {
        if self.currentToken == token {
            self.currentToken = self.lexer.nextToken()
        } else {
            fatalError("Error: eating token: \(token), with current token: \(currentToken)")
        }
    }
    
    /**
     Evaluates the input and returns it's value
     
     - Parameter token: Token to be evaluated
     
     - Returns: Value of Token
     
     */
    private func evaluate(_ token: Token) -> Int {
        switch token {
        case .integer(let val):
            return val
        default:
            fatalError("Error evaluating expression")
        }
    }
    
    /**
     Reads and returns the value of the current integer
     
     - Note: factor: INTEGER | "(" exp ")"
     
     - Returns: Current Integer
     
     */
    private func factor() -> Int {
        if self.currentToken == .parenthesis(.open) {
            self.eat(.parenthesis(.open))
            let result = self.expression()
            self.eat(.parenthesis(.close))
            return result
        } else if self.currentToken == .operation(.minus) {
            self.eat(.operation(.minus))
            return -self.factor()
        } else {
            let token = self.currentToken
            self.eat(.type(.integer))
            return evaluate(token)
        }
    }
    
    /**
     Calculates terms
     
     - Note: term: factor ((MULT | DIV) factor)*
     
     - Returns: Result of terms
     
     */
    private func term() -> Int {
        let operations: [Token] = [.operation(.mult), .operation(.div)]
        
        var result = self.factor()
        while operations.contains(self.currentToken) {
            if self.currentToken == .operation(.mult) {
                self.eat(.operation(.mult))
                result *= self.factor()
            } else if self.currentToken == .operation(.div) {
                self.eat(.operation(.div))
                result /= self.factor()
            }
        }
        return result
    }
    
    /**
     Calculates expressions
     
     - Note: exp: term ((PLUS | MINUS) term)*
     
     - Returns: Result of expressions
     
     */
    private func expression() -> Int {
        let operations: [Token] = [.operation(.minus), .operation(.plus)]
        
        var result = self.term()
        while operations.contains(self.currentToken) {
            if self.currentToken == .operation(.minus) {
                self.eat(.operation(.minus))
                result -= self.term()
            } else if self.currentToken == .operation(.plus) {
                self.eat(.operation(.plus))
                result += self.term()
            }
        }
        return result
    }
    
    /**
     Interprets initialized text
     
     */
    public func parse() -> Int {
        return self.expression()
    }
}
