//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public struct R2Object: Codable, Hashable {
    let checksumAlgorithm: [String]?
    let etag: String?
    let key: String?
    let lastModified: Date?
    let owner: Owner?
    let size: Int?
    let storageClass: String?
    
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
