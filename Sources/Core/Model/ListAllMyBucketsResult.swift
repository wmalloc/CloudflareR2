//
//  ListAllMyBucketsResult.swift
//
//
//  Created by Waqar Malik on 12/25/22.
//

import Foundation

public struct ListAllMyBucketsResult: Codable, Hashable {
    public let buckets: [Bucket]
    public let owner: Owner

    enum CodingKeys: String, CodingKey {
        case buckets = "Buckets"
        case owner = "Owner"
    }
}
