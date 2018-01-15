//
//  main.swift
//  PascalInterpreter
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import Foundation

let quit: [String] = ["q", "quit"]

while true {
    
    print("> ", separator: "", terminator: "")
    
    let txt = readLine()
    
    guard let text = txt, !quit.contains(text.lowercased()) else {
        break
    }
    
    let interpreter = Interpreter(text)
    print(">> = ", separator: "", terminator: "")
    print(interpreter.interpret())
    print("")
}
