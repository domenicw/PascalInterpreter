//
//  BinaryOperation.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class BinaryOperation: AST {
    
    // Token (operation)
    public let token: Token
    // Left node of tree
    public let left: AST
    // Right node of tree
    public let right: AST?
    
    // Initializer
    public init(_ token: Token, left: AST, right: AST?) {
        self.token = token
        self.left = left
        self.right = right
    }
    
}
