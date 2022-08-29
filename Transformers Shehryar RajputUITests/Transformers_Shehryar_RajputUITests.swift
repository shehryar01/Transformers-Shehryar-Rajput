//
//  Transformers_Shehryar_RajputUITests.swift
//  Transformers Shehryar RajputUITests
//
//  Created by macadmin on 27/08/2022.
//

import XCTest

class Transformers_Shehryar_RajputUITests: XCTestCase {

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

        let startitle = app.staticTexts["Start A New Game"]
        XCTAssertTrue(startitle.exists, "Start button present")
        
        let loadtitle = app.staticTexts["Load Game"]
        XCTAssertTrue(loadtitle.exists, "Load button present")
        
        let token = UserDefaults().object(forKey:"token")  as? String ?? String()
        
        if token != String() {
            let button = app.buttons["Load Game"]
            XCTAssertTrue(loadtitle.exists, "token present, using load button")
            button.tap()
        }else {
            
            
            
            let button = app.buttons["Start A New Game"]
            XCTAssertTrue(loadtitle.exists, "token not present, using start button")
            button.tap()
        }
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
