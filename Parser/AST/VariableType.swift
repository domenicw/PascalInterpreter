//
//  VariableType.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 18.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class VariableType: AST {
    
    // Variable Type
    public let type: Type
    
    // Initializer
    public init(_ type: Type) {
        self.type = type
    }
}
