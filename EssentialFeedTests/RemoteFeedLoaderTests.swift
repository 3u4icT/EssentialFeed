//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Sarvjeet Singh on 17/06/21.
//

import XCTest

class RemoteFeedLoader{
    
    let client : HTTPClient
    
    init(client : HTTPClient) {
        self.client = client
    }
    func load(){
        client.get(from: URL.init(string: "https://a-url.com")!)//here the loader has a responsibilty of locating the object that can be removed by composition
    }
}

protocol HTTPClient{
    
    func get(from url : URL)
}


class HTTPClientSpy: HTTPClient{
    
    var requestedURL : URL?
    
     func get(from url: URL) {
        requestedURL = url
    }
    
}
class RemoteFeedLoaderTests : XCTestCase{
    
    func test_init_doesNotRequestDataFromURL(){
        
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client : client)
    
        XCTAssertNil(client.requestedURL)
    }
    
    
    func test_load_requestDataFromURL(){
        
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client : client)
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
    
}
