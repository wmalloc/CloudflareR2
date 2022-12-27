//
//  Bucket.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public struct Bucket: Codable, Hashable, Sendable {
    public let name: String
    public let creationDate: Date

    public init(name: String, creationDate: Date) {
        self.name = name
        self.creationDate = creationDate
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case creationDate = "CreationDate"
    }
}
