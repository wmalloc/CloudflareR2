//
//  Bucket.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public struct Bucket: Codable, Hashable {
    public let name: String
    public let creationDate: Date

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case creationDate = "CreationDate"
    }
}
