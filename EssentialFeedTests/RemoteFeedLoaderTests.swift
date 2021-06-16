//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Sarvjeet Singh on 17/06/21.
//

import XCTest

class RemoteFeedLoader{
    
}

class HTTPClient{
    var requestedURL : URL?
}

class RemoteFeedLoaderTests : XCTestCase{
    
    func test_init_doesNotRequestDataFromURL(){
        
        let client = HTTPClient()
        _ = RemoteFeedLoader()
    
        XCTAssertNil(client.requestedURL)
    }
    
}
