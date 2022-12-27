//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/27/22.
//

import Foundation

public struct Buckets: Codable, Hashable {
    public let buckets: [Bucket]
    
    enum CodingKeys: String, CodingKey {
        case buckets = "Bucket"
    }
}
