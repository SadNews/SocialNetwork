//
//  CrabPeopleTests.swift
//  CrabPeopleTests
//
//  Created by Андрей Ушаков on 23.09.2020.
//

import XCTest
@testable import CrabPeople

class CrabPeopleTests: XCTestCase {
    
    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testValidCallToiTunesGetsHTTPStatusCode200() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testCallToiTunesCompletes() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
