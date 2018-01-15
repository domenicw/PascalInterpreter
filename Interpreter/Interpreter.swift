//
//  Interpreter.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

class Interpreter {
    
    // Parser
    private let parser: Parser
    
    /**
    Initializer for Interpreter class
     
    - Parameter text: Input which needs to be calculated
     
    */
    public init(_ text: String) {
        self.parser = Parser(text)
    }
    
    /**
     Evaluated an AST
     
     - Parameter node: a complete tree or a part of it to evaluate
     
     - Returns: Computed value of tree
     
     */
    private func eval(_ node: AST) -> Int {
        switch node {
        case let operation as BinaryOperation:
            return self.eval(operation)
        case let number as Number:
            return self.eval(number)
        case let unary as UnaryOperation:
            return self.eval(unary)
        default:
            fatalError("Error: unknows node type: \(node)")
        }
    }
    
    /**
     Evaluated Number nodes
     
     - Parameter number: Number node to evaluate
     
     - Returns: Integer value of Number node
     
     */
    private func eval(_ number: Number) -> Int {
        return number.value
    }
    
    /**
     Evaluates BinaryOperation nodes
     
     - Parameter operation: A node to evaluate
     
     - Returns: Integer of operation
     
     */
    private func eval(_ operation: BinaryOperation) -> Int {
        switch operation.token {
        case .operation(.minus):
            return eval(operation.left) - eval(operation.right)
        case .operation(.plus):
            return eval(operation.left) + eval(operation.right)
        case .operation(.mult):
            return eval(operation.left) * eval(operation.right)
        case .operation(.div):
            return eval(operation.left) / eval(operation.right)
        default:
            fatalError("Error: unknow binary operation type \(operation.token)")
        }
    }
    
    /**
     Evaluates UnaryOperation nodes
     
     - Parameter unary: A node to evaluate
     
     - Returns: Integer of operation
     
     */
    private func eval(_ unary: UnaryOperation) -> Int {
        switch unary.token {
        case .operation(.minus):
            return -eval(unary.left)
        case .operation(.plus):
            return eval(unary.left)
        default:
            fatalError("Error: unknown unary operation type \(unary.token)")
        }
    }
    
    
    /**
    Interprets initialized text
     
    */
    public func interpret() -> Int {
        let tree = self.parser.parse()
        //let rpn = RPN(tree)
        //rpn.print()
        return self.eval(tree)
    }
 
}
