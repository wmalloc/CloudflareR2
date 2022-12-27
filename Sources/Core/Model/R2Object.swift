//
//  R2Object.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public struct R2Object: Codable, Hashable, Sendable {
    let checksumAlgorithm: [String]?
    let etag: String?
    let key: String?
    let lastModified: Date?
    let owner: Owner?
    let size: Int?
    let storageClass: String?
    
    public init(checksumAlgorithm: [String]?, etag: String?, key: String?, lastModified: Date?, owner: Owner?, size: Int?, storageClass: String?) {
        self.checksumAlgorithm = checksumAlgorithm
        self.etag = etag
        self.key = key
        self.lastModified = lastModified
        self.owner = owner
        self.size = size
        self.storageClass = storageClass
    }
    
    private enum CodingKeys: String, CodingKey {
        case checksumAlgorithm = "ChecksumAlgorithm"
        case etag = "ETag"
        case key = "Key"
        case lastModified = "LastModified"
        case owner = "Owner"
        case size = "Size"
        case storageClass = "StorageClass"
    }
}
