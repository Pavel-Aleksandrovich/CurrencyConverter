//
//  CurrencyConverter.swift
//  CurrencyConverterUITests
//
//  Created by pavel mishanin on 09.09.2022.
//

import XCTest

class CurrencyConverterUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.tabBars["MainTabBar"].buttons["1"].tap()
    }

    override func tearDownWithError() throws {
    }
    
    func testCollectionView() {
        let collectionView = app.collectionViews["CurrencyConverterCollectionView"]
        XCTAssert(collectionView.exists)
        collectionView.cells["0"].tap()
    }
    
    func testTableView() {
        let tableView = app.tables["CurrencyConverterTableView"]
        XCTAssert(tableView.exists)
        tableView.cells["0"].tap()
        tableView.cells["0"].images["Image"].tap()
        
        XCTAssert(app.tables["CurrencySelectionTableView"].exists)
    }
}
