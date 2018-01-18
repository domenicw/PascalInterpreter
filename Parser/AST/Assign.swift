//
//  Assign.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 15.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Assign: AST {
    
    // Variable
    public let left: Variable
    // Right of assign node
    public let right: AST
    // Token
    public let token: Token
    
    // Initializer
    public init(_ token: Token, left: Variable, right: AST) {
        self.token = token
        self.left = left
        self.right = right
    }
    
}
