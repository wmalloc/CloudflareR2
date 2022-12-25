//
//  File.swift
//
//
//  Created by Waqar Malik on 12/24/22.
//

import AWSClientRuntime
import AWSS3
import ClientRuntime
import Foundation

public struct R2ClientConfig: Hashable, Identifiable {
    public let accountId: String
    public let accessKey: String
    public let secretAccessKey: String

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

extension R2ClientConfig: AWSClientRuntime.CredentialsProvider {
    public func getCredentials() async throws -> AWSClientRuntime.AWSCredentials {
        AWSCredentials(accessKey: accessKey, secret: secretAccessKey, expirationTimeout: 0)
    }
}

extension R2ClientConfig: AWSS3.EndpointResolver {
    public func resolve(params: AWSS3.EndpointParams) throws -> ClientRuntime.Endpoint {
        try ClientRuntime.Endpoint(urlString: endPoint)
    }
}
