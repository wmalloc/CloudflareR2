//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/27/22.
//

import Foundation

public struct Prefix: Codable, Hashable {
    let prefix: String
    
    private enum CodingKeys: String, CodingKey {
        case prefix = "Prefix"
    }
}
