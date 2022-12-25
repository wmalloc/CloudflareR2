//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/25/22.
//

import Foundation
import R2
import WebServiceConcurrency
import WebService
import XMLCoder

public extension R2Client {
    func request<T: Decodable>(route: URLRequestRoutable) async throws -> T {
        try await webService.data(for: try config.request(route: route), transform: { (response) -> T in
            let decoder = XMLDecoder()
            decoder.shouldProcessNamespaces = true
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: response.data)
        })
    }
}

public extension R2Client {
    func buckets() async throws -> ListAllMyBucketsResult {
        try await request(route: R2Route.buckets)
    }
    
    func bucketCors(bucket: String) async throws -> CORSConfiguration {
        try await request(route: R2Route.bucketCors(bucket))
    }
}
