//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Sarvjeet Singh on 17/06/21.
//

import Foundation



public enum LoadFeedResult{
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    associatedtype Error: Swift.Error
    
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
