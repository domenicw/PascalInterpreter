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
        let additions: [String] = ["-(2+2)", "7+13", "(60+ 4)", "2    +       5 "]
        let results: [Int] = [-4, 20, 64, 7]
        for index in 0..<additions.count {
            self.calculateAndCompare(additions[index], result: results[index])
        }
    }
    
    func testSubtraction() {
        let subtractions: [String] = ["1-2", "54-23", "65- 43", "    5       -   2 "]
        let results: [Int] = [-1, 31, 22, 3]
        for index in 0..<subtractions.count {
            self.calculateAndCompare(subtractions[index], result: results[index])
        }
    }
    
    func testAddSub() {
        let calc: [String] = ["1-2  + 4   - 7 +       23", "(54-23)-32-1", "65+ (43  + 3 )- 7", "    5       -   2 + 893", "-2    +  2"]
        let results: [Int] = [19, -2, 104, 896, 0]
        for index in 0..<calc.count {
            self.calculateAndCompare(calc[index], result: results[index])
        }
    }
    
    func testDiv() {
        let div: [String] = ["2/2", "3/  1", "144 / 12", " (  6      /     7 ) "]
        let results: [Int] = [1, 3, 12, 0]
        for index in 0..<div.count {
            self.calculateAndCompare(div[index], result: results[index])
        }
    }
    
    func testMult() {
        let mult: [String] = ["1*2", "(12*12)", "5*    10", "    9       *   8 "]
        let results: [Int] = [2, 144, 50, 72]
        for index in 0..<mult.count {
            self.calculateAndCompare(mult[index], result: results[index])
        }
    }
    
    func testMultDiv() {
        let calc: [String] = ["1*2/2", "6/3*8/4", "12 *12/  12", "    6  /     7  *   12"]
        let results: [Int] = [1, 4, 12, 0]
        for index in 0..<calc.count {
            self.calculateAndCompare(calc[index], result: results[index])
        }
    }
    
    func testAddSubMulDiv() {
        let calc: [String] = ["1*2/2+4", "6/3-8/4", "12 *12+  12- (43*1)", "    6  -     7  *   12", "(3+1)*(4)"]
        let results: [Int] = [5, 0, 113, -78, 16]
        for index in 0..<calc.count {
            self.calculateAndCompare(calc[index], result: results[index])
        }
    }
}
