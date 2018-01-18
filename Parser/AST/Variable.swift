//
//  Variable.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 15.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Variable: AST {
    
    // Variable Token
    public let token: Token
    // Name of variable
    public let name: String
    
    // Initializer
    public init(_ token: Token, name: String) {
        self.token = token
        self.name = name
    }
    
}
