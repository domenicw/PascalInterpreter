//
//  Interpreter.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

class Interpreter {
    
    // Globale Scope
    public private(set) var globalScope: [String: Number]
    
    // Parser
    private let parser: Parser
    
    /**
    Initializer for Interpreter class
     
    - Parameter text: Input which needs to be calculated
     
    */
    public init(_ text: String) {
        self.parser = Parser(text)
        self.globalScope = [:]
    }
    
    /**
     Evaluated an AST
     
     - Parameter node: a complete tree or a part of it to evaluate
     
     - Returns: Computed value of tree
     
     */
    private func eval(_ node: AST) -> Number {
        switch node {
        case let operation as BinaryOperation:
            return self.eval(operation)
        case let number as Number:
            return self.eval(number)
        case let unary as UnaryOperation:
            return self.eval(unary)
        case let compound as Compound:
            self.eval(compound)
        case let assign as Assign:
            self.eval(assign)
        case let variable as Variable:
            return self.eval(variable)
        case let noOp as NoOperation:
            self.eval(noOp)
        case let program as Program:
            self.eval(program)
        case let block as Block:
            self.eval(block)
        case let declaration as VariableDeclaration:
            self.eval(declaration)
        case let type as VariableType:
            self.eval(type)
        default:
            fatalError("Error: unknows node type: \(node)")
        }
        return .integer(0)
    }
    
    /**
     Evaluated Number nodes
     
     - Parameter number: Number node to evaluate
     
     - Returns: Integer value of Number node
     
     */
    private func eval(_ number: Number) -> Number {
        return number
    }
    
    /**
     Evaluates BinaryOperation nodes
     
     - Parameter operation: A node to evaluate
     
     - Returns: Integer of operation
     
     */
    private func eval(_ operation: BinaryOperation) -> Number {
        switch operation.token {
        case .operation(.minus):
            return eval(operation.left) - eval(operation.right)
        case .operation(.plus):
            return eval(operation.left) + eval(operation.right)
        case .operation(.mult):
            return eval(operation.left) * eval(operation.right)
        case .operation(.integerDiv):
            return eval(operation.left) || eval(operation.right)
        case .operation(.floatDiv):
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
    private func eval(_ unary: UnaryOperation) -> Number {
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
     Evaluates Compound nodes
     
     - Parameter compound: A node to evaluate
     
     */
    private func eval(_ compound: Compound) {
        for child in compound.children {
            let _ = self.eval(child)
        }
    }
    
    /**
     Evaluates Assign nodes
     Updates global scope with variable and associated value
     
     - Parameter assign: A node to evaluate
     
     */
    private func eval(_ assign: Assign) {
        let name = assign.left.name
        self.globalScope[name] = self.eval(assign.right)
    }
    
    
    /**
     Evaluates Variable nodes
     
     - Parameter variable: A node to evaluate
     
     - Returns: Value for variable
     
     */
    private func eval(_ variable: Variable) -> Number {
        let name = variable.name
        if let node = self.globalScope[name] {
            return node
        }
        fatalError("Error: variable \(name) is undefined!")
    }
    
    /**
     Evaluates NoOpeation nodes
     
     - Note: Does nothing
     
     - Parameter noOperation: A node to evaluate
     
     */
    private func eval(_ noOperation: NoOperation) {}
    
    /**
     Evaluates VariableTypes
     
     - Parameter type: A VariableType to evaluate
     
     */
    private func eval(_ type: VariableType) {}
    
    /**
     Evaluates VariableDeclarations
     
     - Parameter declaration: A VariableDeclaration to evaluate
     
     */
    private func eval(_ declaration: VariableDeclaration) {}
    
    /**
     Evaluates Block nodes
     
     - Parameter block: A Block node to evaluate
     
     */
    private func eval(_ block: Block) {
        for declaration in block.declarations {
            self.eval(declaration)
        }
        self.eval(block.compound)
    }
    
    /**
     Evaluates Program nodes
     
     - Parameter program: A program node to evaluate
     
     */
    private func eval(_ program: Program) {
        self.eval(program.block)
    }
    
    /**
    Interprets initialized text
     
    */
    public func interpret() {
        let tree = self.parser.parse()
        let _ = self.eval(tree)
    }
 
}
