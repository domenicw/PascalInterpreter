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
        let program = "BEGIN a := 2; END."
        let interpreter = Interpreter(program)
        interpreter.interpret()
        let scope = interpreter.globalScope
        XCTAssertEqual(scope["a"], 2)
    }
    
    func testBasicAdvanceProgram() {
        let program = "BEGIN BEGIN number := 2; a := number; b := 10 * a + 10 * number div 4; c := a - - b END; x := 11; END."
        let interpreter = Interpreter(program)
        interpreter.interpret()
        let scope = interpreter.globalScope
        XCTAssertEqual(scope["b"], 25)
        XCTAssertEqual(scope["number"], 2)
        XCTAssertEqual(scope["a"], 2)
        XCTAssertEqual(scope["x"], 11)
        XCTAssertEqual(scope["c"], 27)
    }
}
