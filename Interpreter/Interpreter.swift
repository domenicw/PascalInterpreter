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
    private var position: Int
    // Current token
    private var currentCharacter: Character?
    
    private var currentToken: Token?
    
    /**
    Initializer for Interpreter class
     
    - Parameter text: Input which needs to be calculated
     
    */
    public init(_ text: String) {
        self.text = text
        self.position = 0
        self.currentCharacter = text[text.index(text.startIndex, offsetBy: 0)]
    }
    
    /**
    Takes the current character and assigns it to its designated Token
     
    - Returns: Token for the current character
     
    */
    private func nextToken() -> Token {
        guard self.text.count > self.position else {
            return Token.eof
        }
        
        if self.currentCharacter == "+" {
            self.advance()
            return Token.plus
        }
        
        if let number = Int("\(self.currentCharacter!)") {
            self.advance()
            return Token.integer(number)
        }
        
        fatalError("Unexpected character: \(self.currentCharacter!) at position: \(self.position)")
    }
    
    /**
    Peeks and returns the next character of the input
     
    - Note: Character does not get consumed
     
    - Returns: The next Character to be parsed
     
    */
    private func peek() -> Character? {
        let peekPosition = self.position + 1
        
        guard peekPosition < self.text.count else { return nil }
        return self.text[self.text.index(self.text.startIndex, offsetBy: peekPosition)]
    }
    
    /**
    Advances to the next character of the input
     
    */
    private func advance() {
        self.position += 1
        guard self.position < self.text.count else {
            self.currentCharacter = nil
            return
        }
        self.currentCharacter = self.text[self.text.index(self.text.startIndex, offsetBy: self.position)]
    }
    
    /**
    Eats the current character
     
    - Parameter token: Type of Token that should be eaten
     
    */
    private func eat(_ token: Token) {
        if self.currentToken! == token {
            self.currentToken = self.nextToken()
        } else {
            fatalError("Error: eating token: \(token) \(currentToken!)")
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
    Expresses the input text
     
     - Post: outputs calculated result
     
    */
    private func expression() {
        self.currentToken = self.nextToken()
        let left = self.currentToken
        self.eat(.type(.integer))
        
        let plus = self.currentToken
        self.eat(.plus)
        
        let right = self.currentToken
        self.eat(.type(.integer))
        
        if self.currentToken == .eof {
            let result = self.evaluate(left!) + self.evaluate(right!)
            
            print(result)
        } else {
            fatalError("Error: input has no end")
        }
        
    }
    
    /**
    Interprets initialized text
     
    */
    public func interpret() {
        self.expression()
    }
 
}
