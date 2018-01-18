//
//  InterpreterTest.swift
//  PascalInterpreterTest
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import XCTest
@testable import PascalInterpreter

class InterpreterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBasicProgram() {
        let program = "PROGRAM test ; var a: integer; {test program} BEGIN a := 2; END."
        let interpreter = Interpreter(program)
        interpreter.interpret()
        let scope = interpreter.globalScope
        XCTAssertEqual(scope["a"], Number.integer(2))
    }
    
    func testBigBasicProgram() {
        let program = "program test; var number, a, x: integer; b, c: real;  BEGIN BEGIN number := 2; a := number; b := 10 * a + 10 * number / 4; c := a - - b END; x := 11; END."
        let interpreter = Interpreter(program)
        interpreter.interpret()
        let scope = interpreter.globalScope
        XCTAssertEqual(scope["b"], Number.real(25))
        XCTAssertEqual(scope["number"], Number.integer(2))
        XCTAssertEqual(scope["a"], Number.integer(2))
        XCTAssertEqual(scope["x"], Number.integer(11))
        XCTAssertEqual(scope["c"], Number.real(27))
    }
}
