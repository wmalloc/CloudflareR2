//
//  ListAllMyBucketsResult.swift
//  
//
//  Created by Waqar Malik on 12/25/22.
//

import Foundation

public struct ListAllMyBucketsResult: Codable {
    public let buckets: [Bucket]
    public let owener: Owner
    
    public struct Bucket: Codable {
        public let name: String
        public let creationDate: Date
    }
    
    public struct Owner: Codable {
        public let id: String
        public let displayName: String
    }
}
