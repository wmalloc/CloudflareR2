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

    public struct Bucket: Codable, Hashable {
        public let name: String
        public let creationDate: Date

        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case creationDate = "CreationDate"
        }
    }

    public struct Owner: Codable, Hashable {
        public let id: String
        public let displayName: String

        enum CodingKeys: String, CodingKey {
            case id = "ID"
            case displayName = "DisplayName"
        }
    }

    enum CodingKeys: String, CodingKey {
        case buckets = "Buckets"
        case owner = "Owner"
    }
}
