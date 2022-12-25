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
    let client: S3Client

    public init(config: R2ClientConfig) async throws {
        self.config = config
        let clientConfiguration = try await S3Client.S3ClientConfiguration(credentialsProvider: config, endpointResolver: config, signingRegion: "us-west-2")
        client = S3Client(config: clientConfiguration)
    }
}

public extension R2Client {
    func download(file: String, fromBucket bucket: String) async throws -> Data {
        let input = GetObjectInput(bucket: bucket, key: file)
        let response = try await client.getObject(input: input)
        // Get the data stream object. Return immediately if there isn't one.
        guard let body = response.body else {
            throw R2Error.notFound
        }
        return body.toBytes().toData()
    }

    func filenames(inBucket bucket: String) async throws -> [String] {
        let input = ListObjectsV2Input(bucket: bucket)
        let output = try await client.listObjectsV2(input: input)
        guard let objects = output.contents else {
            return []
        }
        let names = objects.compactMap { $0.key }
        return names
    }

    func upload(file: URL, toBucket bucket: String, name: String) async throws {
        let fileData = try Data(contentsOf: file)
        try await upload(data: fileData, toBucket: bucket, name: name)
    }

    func upload(data: Data, toBucket bucket: String, name: String) async throws {
        let dataStream = ByteStream.from(data: data)
        let input = PutObjectInput(body: dataStream, bucket: bucket, key: name)
        _ = try await client.putObject(input: input)
    }
    
    func delete(file: String, inBucket bucket: String) async throws {
        let input = DeleteObjectInput(bucket: bucket, key: file)
        _ = try await client.deleteObject(input: input)
    }
}
