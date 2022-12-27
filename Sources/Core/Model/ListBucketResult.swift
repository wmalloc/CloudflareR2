//
//  ListBucketResult.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation


public struct ListBucketResult: Codable, Hashable, Sendable {
    let commonPrefixes: [Prefix]?
    let contents: [R2Object]
    let continuationToken: String?
    let delimiter: String?
    let encodingType: String?
    let isTruncated: Bool
    let keyCount: Int?
    let maxKeys: Int
    let name: String
    let nextContinuationToken: String?
    let prefix: String?
    let startAfter: String?
    let marker: String?
    
    public init(commonPrefixes: [Prefix]?, contents: [R2Object], continuationToken: String?, delimiter: String?, encodingType: String?, isTruncated: Bool, keyCount: Int?, maxKeys: Int, name: String, nextContinuationToken: String?, prefix: String?, startAfter: String?, marker: String?) {
        self.commonPrefixes = commonPrefixes
        self.contents = contents
        self.continuationToken = continuationToken
        self.delimiter = delimiter
        self.encodingType = encodingType
        self.isTruncated = isTruncated
        self.keyCount = keyCount
        self.maxKeys = maxKeys
        self.name = name
        self.nextContinuationToken = nextContinuationToken
        self.prefix = prefix
        self.startAfter = startAfter
        self.marker = marker
    }
    
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
        case marker = "Marker"
    }
}
