//
//  PlusMinusOne_CaseUITests.swift
//  PlusMinusOne-CaseUITests
//
//  Created by Sefa İbiş on 2.11.2023.
//

import XCTest

final class PlusMinusOne_CaseUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    // Tap collection view cell, then navigate to detail page UI Test
    func testSelectCollectionViewItem() throws {
        let app = XCUIApplication()
        app.launch()

        let collectionView = app.collectionViews["collectionViewUserInterfaceTestIdentifier"]

        let cell = collectionView.cells.element(boundBy: 0)
        cell.tap()
        
        let detailPage = app.otherElements["detailPageUserInterfaceTestIdentifier"]
        XCTAssertTrue(detailPage.exists)
    }

    func testLaunchPerformance() throws {
        if #available(iOS 17.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
