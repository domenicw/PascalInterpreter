//
//  Interpreter.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

class Interpreter {
    
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
     
    - Returns: Current Integer
     
    */
    private func term() -> Int {
        let token = self.currentToken
        self.eat(.type(.integer))
        return evaluate(token)
    }
    
    /**
    Expresses the input text
     
     - Post: outputs calculated result
     
    */
    private func expression() -> Int {
        let operations: [Token] = [.operation(.minus), .operation(.plus), .operation(.mult), .operation(.div)]
        var result = self.term()
        
        while operations.contains(self.currentToken) {
            switch currentToken {
            case .operation(.minus):
                self.eat(.operation(.minus))
                result -= self.term()
            case .operation(.plus):
                self.eat(.operation(.plus))
                result += self.term()
            case .operation(.mult):
                self.eat(.operation(.mult))
                result *= self.term()
            case .operation(.div):
                self.eat(.operation(.div))
                result /= self.term()
            default:
                fatalError("Error: this error should never throw. Something went seriously wrong!")
            }
        }
        return result
    }
    
    /**
    Interprets initialized text
     
    */
    public func interpret() -> Int {
        return self.expression()
    }
 
}
