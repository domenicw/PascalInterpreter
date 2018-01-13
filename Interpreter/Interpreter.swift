//
//  Interpreter.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

class Interpreter {
    
    // Input to calculate
    public let text: String
    // Current text position
    private var charPosition: Int
    // Current character
    private var currentCharacter: Character?
    // Current token
    private var currentToken: Token?
    
    /**
    Initializer for Interpreter class
     
    - Parameter text: Input which needs to be calculated
     
    */
    public init(_ text: String) {
        self.text = text
        self.charPosition = 0
        self.currentCharacter = text[text.index(text.startIndex, offsetBy: 0)]
    }
    
    /**
    Skips white spaces of input text
     
    */
    private func skipWhiteSpace() {
        while self.currentCharacter == " " {
            self.advance()
        }
    }
    
    /**
    Combines multiple characters to multi digit integers
     
    - Returns: input integer
     
    */
    private func integer() -> Int {
        var number: Int = 0
        while let currentCharacter = self.currentCharacter, let currentNumber = Int("\(currentCharacter)") {
            number = number * 10 + currentNumber
            self.advance()
        }
        return number
    }
    
    /**
    Takes the current character and assigns it to its designated Token
     
    - Returns: Token for the current character
     
    */
    private func nextToken() -> Token {
        while let currentCharacter = self.currentCharacter {
            
            if currentCharacter == " " {
                self.skipWhiteSpace()
                continue
            }
            
            if currentCharacter == "+" {
                self.advance()
                return Token.operation(.plus)
            }
            
            if currentCharacter == "-" {
                self.advance()
                return Token.operation(.minus)
            }
            
            if currentCharacter == "*" {
                self.advance()
                return Token.operation(.mult)
            }
            
            if currentCharacter == "/" {
                self.advance()
                return Token.operation(.div)
            }
            
            if let _ = Int("\(currentCharacter)") {
                let integer = self.integer()
                return Token.integer(integer)
            }
            
            fatalError("Unexpected character: \(self.currentCharacter!) at position: \(self.charPosition)")
        }
        
        return Token.eof
    }
    
    /**
    Peeks and returns the next character of the input
     
    - Note: Character does not get consumed
     
    - Returns: The next Character to be parsed
     
    */
    private func peek() -> Character? {
        let peekPosition = self.charPosition + 1
        
        guard peekPosition < self.text.count else { return nil }
        return self.text[self.text.index(self.text.startIndex, offsetBy: peekPosition)]
    }
    
    /**
    Advances to the next character of the input
     
    */
    private func advance() {
        self.charPosition += 1
        guard self.charPosition < self.text.count else {
            self.currentCharacter = nil
            return
        }
        self.currentCharacter = self.text[self.text.index(self.text.startIndex, offsetBy: self.charPosition)]
    }
    
    /**
    Eats the current character
     
    - Parameter token: Type of Token that should be eaten
     
    */
    private func eat(_ token: Token) {
        if self.currentToken! == token {
            self.currentToken = self.nextToken()
        } else {
            fatalError("Error: eating token: \(token), with current token: \(currentToken!)")
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
        guard let currentToken = currentToken else {
            fatalError("Error: Current token is not set")
        }
        self.eat(.type(.integer))
        return evaluate(currentToken)
    }
    
    /**
    Expresses the input text
     
     - Post: outputs calculated result
     
    */
    private func expression() -> Int {
        self.currentToken = self.nextToken()
        
        let operations: [Token] = [.operation(.minus), .operation(.plus), .operation(.mult), .operation(.div)]
        var result = self.term()
        
        while let currentToken = self.currentToken, operations.contains(currentToken) {
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
