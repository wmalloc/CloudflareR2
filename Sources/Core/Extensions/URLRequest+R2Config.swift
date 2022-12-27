//
//  URLRequest+R2Config.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation
import WebService

public extension URLRequest {
    func signed(config: R2Config) -> URLRequest {
        let body = self.httpBody ?? "".data(using: .utf8)!
        let signature = body.sha256.lowercased()
        return self.setHeader(HTTPHeader(name: "x-amz-content-sha256", value: signature))
            .signed(service: .s3, region: config.zone, accessKeyId: config.accessKey, secretAccessKey: config.secretAccessKey)
    }
}
