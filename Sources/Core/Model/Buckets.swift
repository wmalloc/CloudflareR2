//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/27/22.
//

import Foundation

public struct Buckets: Codable, Hashable, Sendable {
    public let buckets: [Bucket]
    
    public init(buckets: [Bucket]) {
        self.buckets = buckets
    }
    
    enum CodingKeys: String, CodingKey {
        case buckets = "Bucket"
    }
}
