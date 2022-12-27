//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/27/22.
//

import Foundation

public struct Prefix: Codable, Hashable, Sendable {
    let prefix: String
    
    public init(prefix: String) {
        self.prefix = prefix
    }

    private enum CodingKeys: String, CodingKey {
        case prefix = "Prefix"
    }
}
