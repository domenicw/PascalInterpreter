//
//  ParserTest.swift
//  PascalInterpreterTest
//
//  Created by Domenic Wüthrich on 16.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import XCTest
@testable import PascalInterpreter

class ParserTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBasicPascal() {
        let program = "PROGRAM test ; var a: integer; {test program} BEGIN a := 2; END."
        let parser = Parser(program)
        let _ = parser.parse()
    }
    
    func testBigBasicPascal() {
        let program = "program test; var number, a, x: integer; b, c: real;  BEGIN BEGIN number := 2; a := number; b := 10 * a + 10 * number / 4; c := a - - b END; x := 11; END."
        let parser = Parser(program)
        let _ = parser.parse()
    }

}
