//
//  VariableDeclaration.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 18.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class VariableDeclaration: AST {
    
    // Variable
    public let variable: Variable
    // Type of variable
    public let variableType: VariableType
    
    // Initializer
    public init(_ variable: Variable, variableType: VariableType) {
        self.variable = variable
        self.variableType = variableType
    }
}
