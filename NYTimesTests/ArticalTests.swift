//
//  ArticalTests.swift
//  NYTimesTests
//
//  Created by Damu on 16/11/18.
//  Copyright © 2018 Damu. All rights reserved.
//

import XCTest
@testable import NYTimes

class ArticalTests: XCTestCase {
    var controllerUnderTest: ViewController!

    var sessionUnderTest: URLSession!


    override func setUp() {
        super.setUp()
        
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        controllerUnderTest = (storyBoard.instantiateViewController(withIdentifier: "mainView") as! ViewController)

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        
        sessionUnderTest = nil
        controllerUnderTest = nil

        super.tearDown()


        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
   
    // Asynchronous test: To Test Api
    func testValidCallToArticalsGetsHTTPStatusCode200() {
        // given
        let url = URL(string: controllerUnderTest.apiUrl)
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }

}
