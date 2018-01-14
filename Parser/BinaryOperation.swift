//
//  BinaryOperation.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class BinaryOperation: AST {
    
    public let token: Token
    public let left: AST
    public let right: AST
    
    public init(_ token: Token, left: AST, right: AST) {
        self.token = token
        self.left = left
        self.right = right
    }
    
}
