//
//  CurrencyConverterUnitTests.swift
//  UnitTests
//
//  Created by pavel mishanin on 10.09.2022.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterUnitTests: XCTestCase {

    private var sut: CurrencyConverter!
    
    override func setUpWithError() throws {
        self.sut = CurrencyConverter()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func testRemoveLastNotEmptyString() {
        let string = "1"
        
        let result = self.sut.removeLast(string)
        
        XCTAssertEqual("", result)
    }
    
    func testRemoveLastStringEqualZero() {
        let string = "0,00"
        
        let result = self.sut.removeLast(string)
        
        XCTAssertEqual(string, result)
    }
    
    func testAddValueToString() {
        let string = "1"
        let value = "2"
        
        let result = self.sut.addValue(value, toString: string)
        
        XCTAssertEqual(string + value, result)
    }
    
    func testAddValueToZeroString() {
        let string = "0,00"
        let value = "2"
        
        let result = self.sut.addValue(value, toString: string)
        
        XCTAssertEqual(value, result)
    }
    
    func testAddСommaToString() {
        let string = "15"
        let comma = ","
        
        let result = self.sut.addСomma(comma, toString: string)
        
        XCTAssertEqual(string + comma, result)
    }
    
    func testAddСommaToEmptyString() {
        let string = ""
        let comma = ","
        
        let result = self.sut.addСomma(comma, toString: string)
        
        XCTAssertEqual(string, result)
    }
    
    func testAddСommaToStringThenCommaIsExist() {
        let string = "1,5"
        let comma = ","
        
        let result = self.sut.addСomma(comma, toString: string)
        
        XCTAssertEqual(string, result)
    }
    
    func testRemoveLastEmptyString() {
        let string = ""
        
        let result = self.sut.removeLast(string)
        
        XCTAssertEqual(string, result)
    }
    
    func testGetNominal() {
        let x: Double = 10
        let y: Double = 5
        
        let result = self.sut.getNominal(x: x, y: y)
        
        XCTAssertEqual(2, result)
    }
    
    func testNominalZero() {
        let x: Double = 10
        let y: Double = 0
        
        let result = self.sut.getNominal(x: x, y: y)
        
        XCTAssertEqual(x, result)
    }
    
    func testGetFirstValue() {
        let value: Double = 2
        let first: Double = 3
        let second: Double = 6
        
        let result = self.sut.getFirstValue(value: value, first: first, second: second)
        
        XCTAssertEqual(Double(4), result)
    }
    
    func testGetFirstValueThenFirstIsZero() {
        let value: Double = 2
        let first: Double = 0
        let second: Double = 6
        
        let result = self.sut.getFirstValue(value: value, first: first, second: second)
        
        XCTAssertEqual(Double(12), result)
    }
    
    func testGetSecondValue() {
        let value: Double = 2
        let first: Double = 3
        let second: Double = 6
        
        let result = self.sut.getSecondValue(value: value, first: first, second: second)
        
        XCTAssertEqual(Double(1), result)
    }
    
    func testGetSecondValueThenSecondIsZero() {
        let value: Double = 2
        let first: Double = 6
        let second: Double = 0
        
        let result = self.sut.getSecondValue(value: value, first: first, second: second)
        
        XCTAssertEqual(Double(12), result)
    }
}
