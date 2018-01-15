//
//  Token.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

public enum Token {
    case operation(Operation)
    case type(Type)
    case parenthesis(Parenthesis)
    case begin
    case end
    case dot
    case id
    case assign
    case semi
    case eof
}

public enum Type {
    case integer(Int)
}

public enum Operation {
    case minus
    case plus
    case mult
    case div
}

public enum Parenthesis {
    case open
    case close
}
