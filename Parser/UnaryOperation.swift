//
//  UnaryOperation.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class UnaryOperation: AST {
    
    // Token (operation)
    public let token: Token
    // Next node
    public let left: AST
    
    // Initializer
    public init(_ token: Token, left: AST) {
        self.token = token
        self.left = left
    }
}
