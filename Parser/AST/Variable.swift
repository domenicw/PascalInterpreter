//
//  Variable.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 15.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Variable: AST {
    
    public let token: Token
    public var name: String {
        get {
            if case .id(let name) = token {
                return name
            }
            fatalError("Error: token: \(token) is not a variable")
        }
    }
    
    public init(_ token: Token) {
        self.token = token
    }
    
}
