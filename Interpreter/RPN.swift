//
//  RPN.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class RPN {
    
    // AST to print
    private let tree: AST
    
    // Initializer
    public init(_ tree: AST) {
        self.tree = tree
    }
    
    /**
     Evaluates an AST (RPN mode)
     
     - Parameter node: AST to evaluate
     
     - Returns: Evaluated AST node
     
     */
    private func eval(_ node: AST) -> String {
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
     Evaluates a Number node
     
     - Parameter number: A node to evaluate
     
     - Returns: Evaluated Number node
     
     */
    private func eval(_ number: Number) -> String {
        return "\(number.value) "
    }
    
    /**
     Evaluates a BinaryOperation node
     
     - Parameter operation: A node to evaluate
     
     - Returns: Evaluated BinaryOperation node
     
     */
    private func eval(_ operation: BinaryOperation) -> String {
        switch operation.token {
        case .operation(.minus):
            return "\(eval(operation.left)) \(eval(operation.right)) - "
        case .operation(.plus):
            return "\(eval(operation.left)) \(eval(operation.right)) + "
        case .operation(.mult):
            return "\(eval(operation.left)) \(eval(operation.right)) * "
        case .operation(.div):
            return "\(eval(operation.left)) \(eval(operation.right)) / "
        default:
            fatalError("Error: unknow binary operation type \(operation.token)")
        }
    }
    
    /**
     Evaluates an UnaryOperation node
     
     - Parameter unary: A node to evaluate
     
     - Returns: Evaluated UnaryOperation node
     
     */
    private func eval(_ unary: UnaryOperation) -> String {
        switch unary.token {
        case .operation(.minus):
            return "\(eval(unary.left)) - "
        case .operation(.plus):
            return "\(eval(unary.left)) "
        default:
            fatalError("Error: unknown unary operation type \(unary.token)")
        }
    }
    
    /**
     Prints an AST tree in RPN mode
     
     */
    public func print() {
        let notation = self.eval(self.tree)
        Swift.print(notation)
    }
    
}
