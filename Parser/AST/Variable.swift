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
    public var name: String {
        get {
            if case .id(let name) = token {
                return name
            }
            fatalError("Error: token: \(token) is not a variable")
        }
    }
    
    // Initializer
    public init(_ token: Token) {
        self.token = token
    }
    
}
