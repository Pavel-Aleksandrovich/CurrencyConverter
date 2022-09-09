//
//  ListCurrencies.swift
//  CurrencyConverterUITests
//
//  Created by pavel mishanin on 09.09.2022.
//

import XCTest

class ListCurrenciesUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func testCollectionView() {
        let collectionView = app.collectionViews["ListCurrenciesCollectionView"]
        XCTAssert(collectionView.exists)
        collectionView.cells["0"].tap()
    }
    
    func testTableView() {
        let tableView = app.tables["ListCurrenciesTableView"]
        XCTAssert(tableView.exists)
        tableView.cells["0"].tap()
        tableView.cells["0"].images["Favorite"].tap()
    }
    
    func testTabBar() {
        app.tabBars["MainTabBar"].buttons["0"].tap()
    }
}
