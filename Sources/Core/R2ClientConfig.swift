//
//  File.swift
//
//
//  Created by Waqar Malik on 12/24/22.
//

import Foundation

public struct R2ClientConfig: Hashable, Identifiable {
    public let accountId: String // account-id
    public let accessKey: String // r2-secret-access-key
    public let secretAccessKey: String // r2-access-key-id

    public var id: String {
        accountId
    }

    public init(accountId: String, accessKey: String, secretAccessKey: String) {
        self.accountId = accountId
        self.accessKey = accessKey
        self.secretAccessKey = secretAccessKey
    }
}

public extension R2ClientConfig {
    var endPoint: String {
        "https://\(accountId).r2.cloudflarestorage.com"
    }
}
