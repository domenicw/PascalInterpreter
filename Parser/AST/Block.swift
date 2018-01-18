//
//  Block.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 18.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation
public class Block: AST {
    
    // Variable declarations
    public let declarations: [VariableDeclaration]
    // Compound statement
    public let compound: Compound
    
    // Initializer
    public init(_ declarations: [VariableDeclaration], compound: Compound) {
        self.declarations = declarations
        self.compound = compound
    }
}
