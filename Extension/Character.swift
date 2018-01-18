//
//  Character.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 15.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

extension Character {
    
    /**
     Checks if character is alphabetic
     
     - Returns: True if character is alphabetic
     
     */
    public func isAlpha() -> Bool {
        if let char = self.unicodeScalars.first {
            return CharacterSet.letters.contains(char)
        }
        return false
    }
    
    /**
     Checks if character is numeric
     
     - Returns: True if character is numberic
     
     */
    public func isNumeric() -> Bool {
        if let char = self.unicodeScalars.first {
            return CharacterSet.decimalDigits.contains(char)
        }
        return false
    }
    
    /**
     Checks if character is alphanumeric
     
     - Returns: True if character is alphanumeric
     
     */
    public func isAlphanumeric() -> Bool {
        if let char = self.unicodeScalars.first {
            return CharacterSet.alphanumerics.contains(char)
        }
        return false
    }
    
    /**
     Checks if character is a whitespace or a new line character
     
     - Returns: True if character is a whitespace or a new line character
     
     */
    public func isWhitespaceOrNewLine() -> Bool {
        if let char = self.unicodeScalars.first {
            return CharacterSet.whitespacesAndNewlines.contains(char)
        }
        return false
    }
    
}
