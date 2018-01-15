//
//  Character.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 15.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

extension Character {
    
    public func isAlpha() -> Bool {
        if let char = self.unicodeScalars.first {
            return CharacterSet.letters.contains(char)
        }
        return false
    }
    
    public func isNumeric() -> Bool {
        if let char = self.unicodeScalars.first {
            return CharacterSet.decimalDigits.contains(char)
        }
        return false
    }
    
    public func isAlphanumeric() -> Bool {
        if let char = self.unicodeScalars.first {
            return CharacterSet.alphanumerics.contains(char)
        }
        return false
    }
    
}
