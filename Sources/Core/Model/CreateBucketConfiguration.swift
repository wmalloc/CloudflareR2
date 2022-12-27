//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/27/22.
//

import Foundation

public struct CreateBucketConfiguration: Codable, Hashable, Sendable {
    public let locationConstraint: String
    
    public init(locationConstraint: String) {
        self.locationConstraint = locationConstraint
    }
    
    private enum CodingKeys: String, CodingKey {
        case locationConstraint = "LocationConstraint"
    }
}
