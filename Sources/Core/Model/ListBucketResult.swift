//
//  ListBucketResult.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation


public struct ListBucketResult: Codable, Hashable {
    let commonPrefixes: [Prefix]?
    let contents: [R2Object]
    let continuationToken: String?
    let delimiter: String?
    let encodingType: String?
    let isTruncated: Bool
    let keyCount: Int
    let maxKeys: Int
    let name: String
    let nextContinuationToken: String?
    let prefix: String?
    let startAfter: String?
        
    private enum CodingKeys: String, CodingKey {
        case commonPrefixes = "CommonPrefixes"
        case contents = "Contents"
        case continuationToken = "ContinuationToken"
        case delimiter = "Delimiter"
        case encodingType = "EncodingType"
        case isTruncated = "IsTruncated"
        case keyCount = "KeyCount"
        case maxKeys = "MaxKeys"
        case name = "Name"
        case nextContinuationToken = "NextContinuationToken"
        case prefix = "Prefix"
        case startAfter = "StartAfter"
    }
}
