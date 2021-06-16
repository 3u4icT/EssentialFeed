//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Sarvjeet Singh on 17/06/21.
//

import XCTest

class RemoteFeedLoader{
    func load(){
        HTTPClient.shared.get(from: URL.init(string: "https://a-url.com")!)//here the loader has a responsibilty of locating the object that can be removed by composition
    }
}

class HTTPClient{
    
    static var shared = HTTPClient() // global state instead of singleton
    
    func get(from url : URL){}
}


class HTTPClientSpy: HTTPClient{
    
    var requestedURL : URL?
    
    override func get(from url: URL) {
        requestedURL = url
    }
    
}
class RemoteFeedLoaderTests : XCTestCase{
    
    func test_init_doesNotRequestDataFromURL(){
        
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = RemoteFeedLoader()
    
        XCTAssertNil(client.requestedURL)
    }
    
    
    func test_load_requestDataFromURL(){
        
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let sut = RemoteFeedLoader()
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
    
}
