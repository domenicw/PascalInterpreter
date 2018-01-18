//
//  Number.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 14.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum Number: AST {
    case integer(Int)
    case real(Float)
}
