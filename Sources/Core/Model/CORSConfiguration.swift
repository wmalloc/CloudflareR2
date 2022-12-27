//
//  CORSConfiguration.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public struct CORSConfiguration: Codable, Hashable, Sendable {
    public let rules: [CORSRule]
    
    public init(rules: [CORSRule]) {
        self.rules = rules
    }
    
    public struct CORSRule: Codable, Hashable, Sendable {
        public let allowedOrigin: URL?
        public let allowedMethods: [String]
        public let allowedHeaders: [String]
        public let maxAgeSeconds: TimeInterval
        public let exposeHeader: String?
        
        public init(allowedOrigin: URL?, allowedMethods: [String], allowedHeaders: [String], maxAgeSeconds: TimeInterval, exposeHeader: String?) {
            self.allowedOrigin = allowedOrigin
            self.allowedMethods = allowedMethods
            self.allowedHeaders = allowedHeaders
            self.maxAgeSeconds = maxAgeSeconds
            self.exposeHeader = exposeHeader
        }
        
        private enum CodingKeys: String, CodingKey {
            case allowedOrigin = "AllowedOrigin"
            case allowedMethods = "AllowedMethod"
            case allowedHeaders = "AllowedHeader"
            case maxAgeSeconds = "MaxAgeSeconds"
            case exposeHeader = "ExposeHeader"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case rules = "CORSRule"
    }
}
