//
//  R2Config.swift
//
//
//  Created by Waqar Malik on 12/24/22.
//

import Foundation
import WebService

public struct R2Config: Hashable, Identifiable {
    public let accountId: String // account-id
    public let accessKey: String // r2-secret-access-key
    public let secretAccessKey: String // r2-access-key-id
    public let zone: String

    public var id: String {
        accountId
    }

    public init(accountId: String, accessKey: String, secretAccessKey: String, zone: String = "auto") {
        self.accountId = accountId
        self.accessKey = accessKey
        self.secretAccessKey = secretAccessKey
        self.zone = zone
    }
}

public extension R2Config {
    var host: String {
        "\(accountId).r2.cloudflarestorage.com"
    }
    var endPoint: String {
        "https://\(host)"
    }
    
    var url: URL {
        URL(string: endPoint)!
    }
}
