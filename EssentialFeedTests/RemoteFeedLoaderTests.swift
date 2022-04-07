//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Sarvjeet Singh on 17/06/21.
//

import XCTest
import EssentialFeed

//test commit
class RemoteFeedLoaderTests : XCTestCase{
    
    func test_init_doesNotRequestDataFromURL(){
        
        let (_, client) = makeSUT()
    
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    
    func test_load_requestsDataFromURL(){
        
        let url = URL.init(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url : url)
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
            let url = URL(string: "https://a-given-url.com")!
            let (sut, client) = makeSUT(url: url)

            sut.load()
            sut.load()

            XCTAssertEqual(client.requestedURLs, [url, url])
        }
    
    func test_load_deliversErrorOnClientError() {
            let (sut, client) = makeSUT()
            client.error = NSError(domain: "Test", code: 0)

            var capturedError: RemoteFeedLoader.Error?
            sut.load { error in capturedError = error }

            XCTAssertEqual(capturedError, .connectivity)
        }
    
    
    //MARK: - Helpers
    private func makeSUT(url : URL = URL.init(string: "https://a-url.com")!) -> (sut :RemoteFeedLoader, client : HTTPClientSpy){
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader.init(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient{
        
        var requestedURLs = [URL]()
        var error: Error?
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            if let error = error {
                completion(error) //client will pass it's intejected error
            }
            requestedURLs.append(url)
        }
        
    }
    
}
