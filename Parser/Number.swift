//
//  Number.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Number: AST {
    
    // Number of integer token
    private let token: Token
    
    // Value of integer token
    public var value: Int {
        get {
            if case .type(.integer(let val)) = self.token {
                return val
            }
            fatalError("Error: token: \(self.token) is not a number")
        }
    }
    
    // Initializer
    public init(_ token: Token) {
        self.token = token
    }
    
}
