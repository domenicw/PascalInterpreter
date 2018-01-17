//
//  Parser.swift
//  PascalInterpreter
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
     Parses factors
     
     - Note: factor: [ + | - ] INTEGER | [ + | - ] "(" exp ")"
     
     - Returns: Current Integer
     
     */
    private func factor() -> AST {
        switch self.currentToken {
        case .parenthesis(.open):
            self.eat(.parenthesis(.open))
            let result = self.expression()
            self.eat(.parenthesis(.close))
            return result
        case .operation(.minus):
            self.eat(.operation(.minus))
            return UnaryOperation(Token.operation(.minus), left: self.factor())
        case .operation(.plus):
            self.eat(.operation(.plus))
            return UnaryOperation(Token.operation(.plus), left: self.factor())
        case .constant(.integer):
            let token = self.currentToken
            self.eat(token)
            return Number(token)
        default:
            let variable = self.variable()
            return variable
        }
    }
    
    /**
     Parses terms
     
     - Note: term: factor ((MULT | DIV) factor)*
     
     - Returns: Result of terms
     
     */
    private func term() -> AST {
        let operations: [Token] = [.operation(.mult), .operation(.integerDiv)]
        
        var node = self.factor()
        while operations.contains(self.currentToken) {
            let token = self.currentToken
            if token == .operation(.mult) {
                self.eat(.operation(.mult))
            } else if token == .operation(.integerDiv) {
                self.eat(.operation(.integerDiv))
            }
            node = BinaryOperation(token, left: node, right: self.factor())
        }
        return node
    }
    
    /**
     Parses expressions
     
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
     Parses variable
     
     - Note: variable: ID
     
     - Returns: Result AST of variable
     
     */
    private func variable() -> Variable {
        let variable = Variable(self.currentToken)
        self.eat(.id(variable.name))
        return variable
    }
    
    /**
     Parses assignment statements
     
     - Note: assignmentStatement: variable ASSIGN expr
     
     - Returns: Result AST of assignment statement
     
     */
    private func assignmentStatement() -> AST {
        let left = self.variable()
        let token = self.currentToken
        self.eat(.assign)
        let right = self.expression()
        let assign = Assign(token, left: left, right: right)
        return assign
    }
    
    /**
     Parses empty statement
     
     - Note: empty:
     
     - Returns: Empty AST
     
     */
    private func empty() -> AST {
        return NoOperation()
    }
    
    /**
     Parses statements
     
     - Note: statement: compoundStatement | assignmentStatement | empty
     
     - Returns: Result AST of statement
     
     */
    private func statement() -> AST {
        switch currentToken {
        case .begin:
            return self.compoundStatement()
        case .id:
            return self.assignmentStatement()
        default:
            return self.empty()
        }
    }
    
    /**
     Parses list of statements
     
     - Note: statementList: statement | statement SEMI statementList
     
     - Returns: Array of statements
     
     */
    private func statementList() -> [AST] {
        var list: [AST] = [self.statement()]
        if self.currentToken == .semi {
            self.eat(.semi)
            list.append(contentsOf: self.statementList())
        }
        return list
    }
    
    /**
     Parses compound statements
     
     - Note: compoundStatement: BEGIN statementList END
     
     - Returns: A compound statement
     
     */
    private func compoundStatement() -> AST {
        self.eat(.begin)
        let statements = self.statementList()
        let compound = Compound(statements)
        self.eat(.end)
        return compound
    }
    
    /**
     Parses program
     
     - Note: program: compoundStatement DOT
     
     - Returns: Result AST of program
     
     */
    private func program() -> AST {
        let node = self.compoundStatement()
        self.eat(.dot)
        return node
    }
    
    /**
     Parses initialized text
     
     - Returns: AST of parsed text
     
     */
    public func parse() -> AST {
        let tree = self.program()
        guard self.currentToken == .eof else {
            fatalError("Error: unexpectedly found \(self.currentToken) instead of EOF")
        }
        return tree
    }
}
