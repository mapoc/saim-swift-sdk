//
//  saim_swift_sdkTests.swift
//  saim-swift-sdkTests
//
//  Created by Gian Uy on 9/12/17.
//  Copyright © 2017 POC Team. All rights reserved.
//

import Foundation
import XCTest
@testable import saim_swift_sdk

class saim_swift_sdkTests: XCTestCase {
    
    let base_url = "https://apisb.shop.com/saim/v1"
    let api_key = ""
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1PostHouseholds() throws {
        let requestDict = [ "first_name":"John",
                            "last_name":"Doe",
                            "address": "Cardboard Box #3",
                            "email": "homeless@nowhere.com",
                            "primary_phone": "(123) 456-7890"]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestDict, options: .prettyPrinted)
        
        let session = URLSession.shared
        
        let url = NSURL(string: "\(base_url)/households")!
        
        let exp = expectation(description: "Wait for \(url) to load.")
        
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(api_key)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = jsonData
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) -> Void in
                guard let _: Data = data, let _: URLResponse = response, error == nil
                    else {
                        print("*****error")
                        debugPrint(error!)
                        return
                    }
            debugPrint(data!)
            
            let urlREsponse = response as? HTTPURLResponse
            
            XCTAssertEqual(urlREsponse?.statusCode, 201)
            
            let json = try? JSONSerialization.jsonObject(with:data!)
            
            
            
            exp.fulfill()
        })
        
        task.resume()
    
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
