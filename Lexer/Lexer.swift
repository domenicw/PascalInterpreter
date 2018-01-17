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
        "PROGRAM": .program,
        "VAR": .variable,
        "INTEGER": .type(.integer),
        "REAL": .type(.real),
        "BEGIN": .begin,
        "END": .end,
        "DIV": .operation(.integerDiv)
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
     Skips white spaces input program
     
     */
    private func skipWhiteSpace() {
        while let currentChar = self.currentCharacter, currentChar == " " {
            self.advance()
        }
    }
    
    /**
     Skips comments in input program
     
     */
    private func skipComments() {
        while let currentChar = self.currentCharacter, currentChar != "}" {
            self.advance()
        }
        self.advance()
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
        while let char = self.currentCharacter, char.isAlphanumeric() || char == "_"  {
            lexem += String(char)
            self.advance()
        }
        if let token = self.keywords[lexem.uppercased()] {
            return token
        }
        return .id(lexem)
    }
    
    /**
     Combines multiple characters to multi digit constant number
     
     - Returns: input constant number
     
     */
    private func number() -> Constant {
        var number: String = ""
        while let currentChar = self.currentCharacter, currentChar.isNumeric() {
            number += String(currentChar)
            self.advance()
        }
        
        if let currentChar = self.currentCharacter, currentChar == "." {
            number += String(currentChar)
            repeat {
                number += String(currentChar)
                self.advance()
            } while currentChar.isNumeric()
            return .real(Float(number)!)
        }
        
        return .integer(Int(number)!)
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
            
            if currentCharacter == "{" {
                self.skipComments()
                continue
            }
            
            if currentCharacter.isAlpha() || currentCharacter == "_" {
                return self.id()
            }
            
            if currentCharacter == "." {
                self.advance()
                return .dot
            }
            
            if currentCharacter == ":" && self.peek() == "=" {
                self.advance()
                self.advance()
                return .assign
            }
            
            if currentCharacter == ";" {
                self.advance()
                return .semi
            }
            
            if currentCharacter == "," {
                self.advance()
                return .coma
            }
            
            if currentCharacter == ":" {
                self.advance()
                return .colon
            }
            
            if currentCharacter == "+" {
                self.advance()
                return .operation(.plus)
            }
            
            if currentCharacter == "-" {
                self.advance()
                return .operation(.minus)
            }
            
            if currentCharacter == "*" {
                self.advance()
                return .operation(.mult)
            }
            
            if currentCharacter == "/" {
                self.advance()
                return .operation(.floatDiv)
            }
            
            if currentCharacter == "(" {
                self.advance()
                return .parenthesis(.open)
            }
            
            if currentCharacter == ")" {
                self.advance()
                return .parenthesis(.close)
            }
            
            if currentCharacter.isNumeric() {
                return .constant(self.number())
            }
            
            fatalError("Unexpected character: \(self.currentCharacter!) at position: \(self.charPosition)")
        }
        
        return .eof
    }
}
