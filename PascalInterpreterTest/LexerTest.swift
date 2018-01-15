//
//  LexerTest.swift
//  PascalInterpreterTest
//
//  Created by Domenic Wüthrich on 15.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import XCTest
@testable import PascalInterpreter

class LexerTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBasicPascal() {
        let program = "BEGIN a := 2; END."
        let lexer = Lexer(program)
        let begin = lexer.nextToken()
        XCTAssertEqual(begin, .begin)
        let a = lexer.nextToken()
        XCTAssertEqual(a, .id("a"))
        let assign = lexer.nextToken()
        XCTAssertEqual(assign, .assign)
        let digit = lexer.nextToken()
        XCTAssertEqual(digit, .type(.integer(2)))
        let semi = lexer.nextToken()
        XCTAssertEqual(semi, .semi)
        let end = lexer.nextToken()
        XCTAssertEqual(end, .end)
        let dot = lexer.nextToken()
        XCTAssertEqual(dot, .dot)
        let eof = lexer.nextToken()
        XCTAssertEqual(eof, .eof)
    }

}
