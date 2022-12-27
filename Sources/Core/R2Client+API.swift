//
//  R2Client+API.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public extension R2Client {
    /**
     Returns a list of all buckets owned by the authenticated sender of the request.
     
     - parameter completion: Completion Handler
     
     - returns: Data Task which can be canceled
     */
    func buckets(completion: ((Result<ListAllMyBucketsResult, Error>) -> Void)?) -> URLSessionDataTask? {
        request(route: R2Route.buckets, completion: completion)
    }
    
    /**
     Returns the Cross-Origin Resource Sharing (CORS) configuration information set for the bucket.
     
     - parameter bucket:     The bucket name for which to get the cors configuration.
     - parameter completion: Completion Handler
     
     - returns: Data Task which can be canceled
     */
    func bucketCors(bucket: String, completion: ((Result<CORSConfiguration, Error>) -> Void)?) -> URLSessionDataTask? {
        request(route: R2Route.bucketCors(bucket), completion: completion)
    }
    
    /**
     Returns some or all (up to 1,000) of the objects in a bucket with each request. You can use the request parameters as selection criteria to return a subset of the objects in a bucket.
     
     - parameter bucket:     The bucket name containing the objects.
     - parameter parameters: parameters (Default: nil) `list-type, continuation-token, delimiter, encoding-type, fetch-owner, max-keys, prefix, start-after`
     - parameter completion: Completion Handler
     
     - returns: Data Task which can be canceled
     */
    func objects(bucket: String, parameters: [String: String?]? = nil, completion: ((Result<ListBucketResult, Error>) -> Void)?) -> URLSessionDataTask? {
        request(route: R2Route.objects(bucket), parameters: parameters, completion: completion)
    }
    
    /**
     Retrieves objects from Cloudflare R2.
     
     - parameter name:       The object name to get
     - parameter bucket:     The bucket name containing the object.
     - parameter parameters: parameters (Default: nil) `partNumber, response-cache-control,response-content-disposition,response-content-encoding,response-content-language,response-content-type,response-expires,versionId`

     - parameter completion: Completion Handler
     
     - returns: Data Task which can be canceled
     */
    func object(name: String, fromBucket bucket: String, parameters: [String: String?]? = nil, completion: ((Result<Data, Error>) -> Void)?) -> URLSessionDataTask? {
        data(route: R2Route.object(name, bucket), parameters: parameters, completion: completion)
    }
}
