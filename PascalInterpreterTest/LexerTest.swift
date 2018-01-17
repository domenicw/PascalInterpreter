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
        XCTAssertEqual(lexer.nextToken(), .begin)
        XCTAssertEqual(lexer.nextToken(), .id("a"))
        XCTAssertEqual(lexer.nextToken(), .assign)
        XCTAssertEqual(lexer.nextToken(), .constant(.integer(2)))
        XCTAssertEqual(lexer.nextToken(), .semi)
        XCTAssertEqual(lexer.nextToken(), .end)
        XCTAssertEqual(lexer.nextToken(), .dot)
        XCTAssertEqual(lexer.nextToken(), .eof)
    }
    
    func testBasicAdvancePascal() {
        let program = "begin { hey tests :) } var x: integer; y : real; begin x := 5; y := x div 2 end end."
        let lexer = Lexer(program)
        XCTAssertEqual(lexer.nextToken(), .begin)
        XCTAssertEqual(lexer.nextToken(), .variable)
        XCTAssertEqual(lexer.nextToken(), .id("x"))
        XCTAssertEqual(lexer.nextToken(), .colon)
        XCTAssertEqual(lexer.nextToken(), .type(.integer))
        XCTAssertEqual(lexer.nextToken(), .semi)
        XCTAssertEqual(lexer.nextToken(), .id("y"))
        XCTAssertEqual(lexer.nextToken(), .colon)
        XCTAssertEqual(lexer.nextToken(), .type(.real))
        XCTAssertEqual(lexer.nextToken(), .semi)
        XCTAssertEqual(lexer.nextToken(), .begin)
        XCTAssertEqual(lexer.nextToken(), .id("x"))
        XCTAssertEqual(lexer.nextToken(), .assign)
        XCTAssertEqual(lexer.nextToken(), .constant(.integer(5)))
        XCTAssertEqual(lexer.nextToken(), .semi)
        XCTAssertEqual(lexer.nextToken(), .id("y"))
        XCTAssertEqual(lexer.nextToken(), .assign)
        XCTAssertEqual(lexer.nextToken(), .id("x"))
        XCTAssertEqual(lexer.nextToken(), .operation(.integerDiv))
        XCTAssertEqual(lexer.nextToken(), .constant(.integer(2)))
        XCTAssertEqual(lexer.nextToken(), .end)
        XCTAssertEqual(lexer.nextToken(), .end)
        XCTAssertEqual(lexer.nextToken(), .dot)
        XCTAssertEqual(lexer.nextToken(), .eof)
    }

}
