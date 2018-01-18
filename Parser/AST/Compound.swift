//
//  Compound.swift
//  PascalInterpreterTest
//
//  Created by Domenic Wüthrich on 15.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Compound: AST {
    
    // Compound children
    public var children: [AST] = []
    
    // Initializer
    public init(_ children: [AST]) {
        self.children = children
    }
    
}
