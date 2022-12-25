//
//  CORSConfiguration.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public struct CORSConfiguration: Codable, Hashable {
    public let rules: [CORSRule]
    
    public struct CORSRule: Codable, Hashable {
        public let allowedOrigin: URL?
        public let allowedMethods: [String]
        public let allowedHeaders: [String]
        public let maxAgeSeconds: TimeInterval
        public let exposeHeader: String?
        
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
