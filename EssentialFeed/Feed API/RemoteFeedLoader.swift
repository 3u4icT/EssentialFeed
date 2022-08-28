//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Sarvjeet Singh on 07/04/22.
//

import Foundation


public class RemoteFeedLoader: FeedLoader{
    
    private let client : HTTPClient
    private let url : URL
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadFeedResult<Error>
    
    public init(url : URL, client : HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return } // since the map function in FeedItemsMapper is static it can get invoked even when RemoteFeedLoader is deallocated.so we need to put a check via test and put a self check here.FeedMapper can outlive RemoteFeedLoader.
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
