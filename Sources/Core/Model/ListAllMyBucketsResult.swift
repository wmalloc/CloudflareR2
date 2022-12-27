//
//  ListAllMyBucketsResult.swift
//
//
//  Created by Waqar Malik on 12/25/22.
//

import Foundation

public struct ListAllMyBucketsResult: Codable, Hashable, Sendable {
    public let buckets: Buckets
    public let owner: Owner

    public init(buckets: Buckets, owner: Owner) {
        self.buckets = buckets
        self.owner = owner
    }
    
    private enum CodingKeys: String, CodingKey {
        case buckets = "Buckets"
        case owner = "Owner"
    }
}
