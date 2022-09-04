//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Sarvjeet Singh on 01/09/22.
//

import Foundation
import XCTest

//end to end test have dependency on network and backend so better to do it in later multi- module integration testing


class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in }.resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    
    
    func test_getFromURL_resumesDataTaskWithURL() {
            let url = URL(string: "http://any-url.com")!
            let session = URLSessionSpy()
            let task = URLSessionDataTaskSpy()
            session.stub(url: url, task: task)

            let sut = URLSessionHTTPClient(session: session)

            sut.get(from: url)

            XCTAssertEqual(task.resumeCallCount, 1)
        }
    // MARK: - Helpers
    
    private class URLSessionSpy: URLSession { // subclass to spy; but avoid using external classes for this it couples your tests with the implementation of other's code
        private var stubs = [URL: URLSessionDataTask]()
        
        func stub(url: URL, task: URLSessionDataTask) {
            stubs[url] = task
        }
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return stubs[url] ?? FakeURLSessionDataTask()
        }
    }
    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
            var resumeCallCount = 0

            override func resume() {
                resumeCallCount += 1
            }
        }
}
