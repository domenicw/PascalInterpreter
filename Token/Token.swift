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
    case constant(Constant)
    case parenthesis(Parenthesis)
    case program
    case variable
    case begin
    case end
    case dot
    case colon
    case coma
    case id(String)
    case assign
    case semi
    case eof
}

public enum Constant {
    case integer(Int)
    case real(Float)
}

public enum Type {
    case integer
    case real
}

public enum Operation {
    case minus
    case plus
    case mult
    case integerDiv
    case floatDiv
}

public enum Parenthesis {
    case open
    case close
}
