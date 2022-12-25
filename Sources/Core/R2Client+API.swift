//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public extension R2Client {
    func buckets(completion: ((Result<ListAllMyBucketsResult, Error>) -> Void)?) -> URLSessionDataTask? {
        request(route: R2Route.buckets, completion: completion)
    }
    
    func bucketCors(bucket: String, completion: ((Result<CORSConfiguration, Error>) -> Void)?) -> URLSessionDataTask? {
        request(route: R2Route.bucketCors(bucket), completion: completion)
    }
}
