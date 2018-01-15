//
//  Assign.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 15.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Assign: AST {
    
    public let left: Variable
    public let right: AST
    public let token: Token
    
    public init(_ token: Token, left: Variable, right: AST) {
        self.token = token
        self.left = left
        self.right = right
    }
    
}
