//
//  CurrencySelectionUITests.swift
//  CurrencyConverterUITests
//
//  Created by pavel mishanin on 09.09.2022.
//

import XCTest

class CurrencySelectionUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.tabBars["MainTabBar"].buttons["1"].tap()
        let tableView = app.tables["CurrencyConverterTableView"]
        tableView.cells["0"].images["Image"].tap()
    }

    override func tearDownWithError() throws {
    }
    
    func testTableView() {
        let tableView = app.tables["CurrencySelectionTableView"]
        XCTAssert(tableView.exists)
        tableView.cells["0"].tap()
        
        XCTAssert(app.tables["CurrencyConverterTableView"].waitForExistence(timeout: 1.0))
    }
}
