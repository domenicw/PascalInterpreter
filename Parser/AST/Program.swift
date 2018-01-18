//
//  Program.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 18.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public class Program: AST {
    
    // Name of program
    public let name: String
    // Program block
    public let block: Block
    
    // Initializer
    public init(_ name: String, block: Block) {
        self.name = name
        self.block = block
    }
}
