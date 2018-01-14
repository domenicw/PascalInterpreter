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
     Reads and returns the value of the current integer
     
     - Note: factor: INTEGER | "(" exp ")"
     
     - Returns: Current Integer
     
     */
    private func factor() -> AST {
        if self.currentToken == .parenthesis(.open) {
            self.eat(.parenthesis(.open))
            let result = self.expression()
            self.eat(.parenthesis(.close))
            return result
        } else if self.currentToken == .operation(.minus) {
            self.eat(.operation(.minus))
            return BinaryOperation(Token.operation(.minus), left: self.factor(), right: nil)
        } else {
            let token = self.currentToken
            self.eat(.type(.integer))
            return Number(token)
        }
    }
    
    /**
     Calculates terms
     
     - Note: term: factor ((MULT | DIV) factor)*
     
     - Returns: Result of terms
     
     */
    private func term() -> AST {
        let operations: [Token] = [.operation(.mult), .operation(.div)]
        
        var node = self.factor()
        while operations.contains(self.currentToken) {
            let token = self.currentToken
            if token == .operation(.mult) {
                self.eat(.operation(.mult))
            } else if token == .operation(.div) {
                self.eat(.operation(.div))
            }
            node = BinaryOperation(token, left: node, right: self.factor())
        }
        return node
    }
    
    /**
     Calculates expressions
     
     - Note: exp: term ((PLUS | MINUS) term)*
     
     - Returns: Result of expressions
     
     */
    private func expression() -> AST {
        let operations: [Token] = [.operation(.minus), .operation(.plus)]
        
        var node = self.term()
        while operations.contains(self.currentToken) {
            let token = self.currentToken
            if token == .operation(.minus) {
                self.eat(.operation(.minus))
            } else if token == .operation(.plus) {
                self.eat(.operation(.plus))
            }
            node = BinaryOperation(token, left: node, right: self.term())
        }
        return node
    }
    
    /**
     Parses initialized text
     
     - Returns: AST of parsed text
     */
    public func parse() -> AST {
        return self.expression()
    }
}
