//
//  Owner.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public struct Owner: Codable, Hashable {
    public let id: String
    public let displayName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case displayName = "DisplayName"
    }
}
