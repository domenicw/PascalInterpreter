//
//  main.swift
//  Calculator
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

let text = readLine()

if let text = text {
    let interpreter = Interpreter(text)
    interpreter.interpret()
} else {
    fatalError("Error: no input!")
}

