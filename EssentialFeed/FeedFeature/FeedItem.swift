//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Sarvjeet Singh on 17/06/21.
//

import Foundation


public struct FeedItem: Equatable{
    let id : UUID
    let description : String?
    let location : String?
    let imageURL : URL
}
