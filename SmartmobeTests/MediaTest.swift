//
//  MediaTest.swift
//  SmartmobeTests
//
//  Created by Asmin Ghale on 4/12/19.
//  Copyright © 2019 default. All rights reserved.
//

import XCTest
@testable import Smartmobe

class MediaTests: XCTestCase{
    
    func testParseResultValidJSON(){
        let dictionary: NSDictionary = [
            "images": [
                [
                "id": 202,
                "large_url":"www.com",
                "url":"abc.com",
                ]
            ]
        ]
        
        let parse = Media.parseResult(data: dictionary)
        XCTAssertEqual(parse.first!.id, 202)
        XCTAssertEqual(parse.first!.largeURL, "www.com")
        XCTAssertEqual(parse.first!.url, "abc.com")
        XCTAssertEqual(parse.first!.sourceID, nil)
    }
    
    
    
    func testParseResultInvalidJSON(){
        let dictionary: NSDictionary = [
            "foods": [
                [
                    "id": 202,
                    "large_url":"www.com",
                    "url":"abc.com",
                    ]
            ]
        ]
        let parse = Media.parseResult(data: dictionary)
        let count = parse.count == 0
        XCTAssertTrue(count)
    }
    
    func testParseSourceWithErrorMessage(){
        let dictionary:NSDictionary = [
            "message": "This is an error."
        ]
        let parse = Media.parseSource(data: dictionary)
        XCTAssertNil(parse.id)
        XCTAssertNil(parse.name)
        XCTAssertNil(parse.url)
        XCTAssertEqual(parse.message, "This is an error.")
    }
    
    func testParseSourceWithValidResult(){
        let dictionary:NSDictionary = [
            "id": 202,
            "name":"John Doe",
            "url":"www.johndoe.com"
        ]
        let parse = Media.parseSource(data: dictionary)
        XCTAssertNil(parse.message)
        XCTAssertEqual(parse.id, 202)
        XCTAssertEqual(parse.name, "John Doe")
        XCTAssertEqual(parse.url, "www.johndoe.com")
    }
    
}
