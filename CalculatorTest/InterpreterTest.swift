//
//  InterpreterTest.swift
//  CalculatorTest
//
//  Created by Domenic Wüthrich on 13.01.18.
//  Copyright © 2018 Domenic Wüthrich. All rights reserved.
//

import XCTest
@testable import Calculator

class InterpreterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func calculateAndCompare(_ calculation: String, result: Int) {
        let interpreter = Interpreter(calculation)
        XCTAssertEqual(interpreter.interpret(), result)
    }
    
    func testAddition() {
        let additions: [String] = ["1+2", "7+13", "60+ 4", "2    +       5 "]
        let results: [Int] = [3, 20, 64, 7]
        for index in 0..<additions.count {
            self.calculateAndCompare(additions[index], result: results[index])
        }
    }
    
    func testSubtraction() {
        let subtractions: [String] = ["1-2", "54-23", "65- 43", "    5       -   2 "]
        let results: [Int] = [-1, 31, 22, 3]
        for index in 0..<additions.count {
            self.calculateAndCompare(additions[index], result: results[index])
        }
    }
}
