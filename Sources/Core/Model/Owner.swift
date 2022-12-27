//
//  Owner.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public struct Owner: Codable, Hashable, Sendable {
    public let id: String
    public let displayName: String

    public init(id: String, displayName: String) {
        self.id = id
        self.displayName = displayName
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case displayName = "DisplayName"
    }
}
