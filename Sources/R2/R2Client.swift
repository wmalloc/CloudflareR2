//
//  R2Client.swift
//
//
//  Created by Waqar Malik on 12/24/22.
//

import AWSClientRuntime
import AWSS3
import ClientRuntime
import Foundation

public enum Buckets {
    public static let netcastImages = "netcast-images"
    public static let netcastVidoes = "netcast-videos"
}

public class R2Client {
    let config: R2ClientConfig
    let s3Client: S3Client

    public init(config: R2ClientConfig) async throws {
        self.config = config
        let clientConfiguration = try await S3Client.S3ClientConfiguration(credentialsProvider: config, endpointResolver: config)
        s3Client = S3Client(config: clientConfiguration)
    }
}

public extension R2Client {
    func download(bucket: String, key: String) async throws -> Data {
        let input = GetObjectInput(bucket: bucket, key: key)
        let output = try await s3Client.getObject(input: input)
        // Get the data stream object. Return immediately if there isn't one.
        guard let body = output.body else {
            throw R2Error.notFound
        }
        return body.toBytes().toData()
    }
}
