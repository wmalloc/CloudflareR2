//
//  R2Client.swift
//
//
//  Created by Waqar Malik on 12/24/22.
//

import Foundation
import WebService
import AWS4
import CryptoKit
import XMLCoder

public class R2Client {
    let config: R2ClientConfig
    let webService: WebService
    
    public init(config: R2ClientConfig, webService: WebService = WebService(session: .shared)) {
        self.config = config
        self.webService = webService
    }
}

public extension R2Client {
    func buckets(completion: ((Result<[String], Error>) -> Void)?) -> URLSessionDataTask? {
        let signature = "".data(using: .utf8)!.sha256.lowercased()
        let request = URLRequest(url: config.url)
            .setContentType(URLRequest.ContentType.json)
            .setHeader(HTTPHeader(name: URLRequest.Header.contentLength, value: "0"))
            .setHeader(HTTPHeader(name: "x-amz-content-sha256", value: signature))
            .signed(service: .s3, region: "auto", accessKeyId: config.accessKey, secretAccessKey: config.secretAccessKey)
        
        return webService.dataTask(with: request) { result in
            switch result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let data):
                let decoder = XMLDecoder()
                decoder.shouldProcessNamespaces = true
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let bucketResult = try decoder.decode(ListAllMyBucketsResult.self, from: data)
                    print(bucketResult)
                } catch {
                    print(error)
                }
                completion?(.success([]))
            }
        }
    }
}
