//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Damu on 15/11/18.
//  Copyright © 2018 Damu. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let app = XCUIApplication()
        let nyTimesMostPopularNavigationBar = app.navigationBars["NY Times Most Popular"]
        nyTimesMostPopularNavigationBar.children(matching: .button).element(boundBy: 0).tap()
        
        let okButton = app.alerts["Message"].buttons["Ok"]
        okButton.tap()
        nyTimesMostPopularNavigationBar.buttons["Search"].tap()
        okButton.tap()
        nyTimesMostPopularNavigationBar.buttons["Item"].tap()
        okButton.tap()
        let tablesQuery = app.tables
        let cell = tablesQuery.cells
        //        let cell = cellQuery.children(matching: .staticText)
        let cellElement = cell.element(boundBy: 1)
        cellElement.tap()
        
    }

}
