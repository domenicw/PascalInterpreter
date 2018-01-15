//
//  Lexer.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

class Lexer {
    
    // Input to calculate
    public let text: String
    // Current text position
    private var charPosition: Int
    // Current character
    private var currentCharacter: Character?
    // Reserved Keywords
    private let keywords: [String: Token] = [
        "BEGIN": .begin,
        "END": .end
    ]
    
    /**
    Initializer for the Lexer
     
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
     Combines multiple characters to ids
     
     - Returns: keyword token or id token
     
     */
    private func id() -> Token {
        var lexem = ""
        while let char = self.currentCharacter, char.isAlphanumeric() {
            lexem += String(char)
            self.advance()
        }
        if let token = self.keywords[lexem] {
            return token
        }
        return .id(lexem)
    }
    
    /**
     Combines multiple characters to multi digit integers
     
     - Returns: input integer
     
     */
    private func integer() -> Int {
        var number: Int = 0
        while let currentChar = self.currentCharacter, currentChar.isNumeric(), let digit = Int("\(currentChar)") {
            number = number * 10 + digit
            self.advance()
        }
        return number
    }
    
    /**
     Takes the current character and assigns it to its designated Token
     
     - Returns: Token for the current character
     
     */
    public func nextToken() -> Token {
        while let currentCharacter = self.currentCharacter {
            
            if currentCharacter == " " {
                self.skipWhiteSpace()
                continue
            }
            
            if currentCharacter.isAlpha() {
                return self.id()
            }
            
            if currentCharacter == "." {
                self.advance()
                return Token.dot
            }
            
            if currentCharacter == ":" && self.peek() == "=" {
                self.advance()
                self.advance()
                return Token.assign
            }
            
            if currentCharacter == ";" {
                self.advance()
                return Token.semi
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
            
            if currentCharacter == "(" {
                self.advance()
                return Token.parenthesis(.open)
            }
            
            if currentCharacter == ")" {
                self.advance()
                return Token.parenthesis(.close)
            }
            
            if let _ = Int("\(currentCharacter)") {
                let integer = self.integer()
                return Token.type(.integer(integer))
            }
            
            fatalError("Unexpected character: \(self.currentCharacter!) at position: \(self.charPosition)")
        }
        
        return Token.eof
    }
}
