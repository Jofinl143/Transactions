//
//  TransactionsUITests.swift
//  TransactionsUITests
//
//  Created by Jofin George on 30/03/21.
//

import XCTest

class TransactionsUITests: XCTestCase {

    var app: XCUIApplication = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        XCTAssert(app.wait(for: .runningForeground, timeout: 10))

        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTransactionFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Make sure we're displaying onboarding
        self.waitForElementToAppear(element: app.staticTexts["lblSummary"])
        
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.count > 0)
        app.tables.element(boundBy: 0).cells.element(boundBy: 4).tap()
        
        XCTAssertEqual(app.staticTexts["lblAmount"].label, "- $250.99")
        XCTAssertEqual(app.staticTexts["lblName"].label, "David John")
        XCTAssertEqual(app.staticTexts["lblGst"].label, "GST : $37.65")
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.count > 0)
        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()

        app.navigationBars.buttons.element(boundBy: 0).tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func waitForElementToAppear(element: XCUIElement, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)

        waitForExpectations(timeout: 30) { (error) -> Void in
            if (error != nil) {
                _ = "Failed to find \(element) after 30 seconds."
            }
        }
    }
}
