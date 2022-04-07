//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Sarvjeet Singh on 07/04/22.
//

import Foundation


public protocol HTTPClient{
    
    func get(from url : URL)
}



public class RemoteFeedLoader{
    
    private let client : HTTPClient
    private let url : URL
    public init(url : URL, client : HTTPClient) {
        self.client = client
        self.url = url
    }
    public func load(){
        client.get(from: url)
}
}
