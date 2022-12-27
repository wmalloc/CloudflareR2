//
//  R2Client+Concurrency.swift
//  
//
//  Created by Waqar Malik on 12/25/22.
//

import Foundation
import R2
import WebServiceConcurrency
import WebService
import XMLCoder
import UniformTypeIdentifiers

public extension R2Client {
    /**
     Return raw data

     - parameter route:      where to get the data
     - parameter parameters: If you need to add extra query parmeters to the query (Default: nil)
     - parameter headers:    extra headers (Default: nil)
     
     - returns: Data
     */
    func data(route: URLRequestRoutable, parameters: [String: String?]? = nil, headers: [HTTPHeader]? = nil) async throws -> Data {
        let response = try await webService.data(for: try config.request(route: route, parameters: parameters, headers: headers))
        return response.data
    }

    /**
     Return decoded data object

     - parameter route:      where to get the data
     - parameter parameters: If you need to add extra query parmeters to the query (Default: nil)
     - parameter headers:    extra headers (Default: nil)
     
     - returns: Object
     */
    func request<T: Decodable>(route: URLRequestRoutable, parameters: [String: String?]? = nil, headers: [HTTPHeader]? = nil) async throws -> T {
        try await webService.data(for: try config.request(route: route, parameters: parameters, headers: headers ), transform: { (response) -> T in
            let decoder = XMLDecoder()
            decoder.shouldProcessNamespaces = true
            decoder.dateDecodingStrategy = .formatted(self.rfc3339DateFormatter)
            return try decoder.decode(T.self, from: response.data)
        })
    }
}

public extension R2Client {
    /**
     Returns a list of all buckets owned by the authenticated sender of the request.
     
     - returns: `ListAllMyBucketsResult`
     */
    func listBuckets() async throws -> ListAllMyBucketsResult {
        try await request(route: R2Route.buckets)
    }
    
    /**
     Returns the Cross-Origin Resource Sharing (CORS) configuration information set for the bucket.
     
     - parameter bucket:     The bucket name for which to get the cors configuration.
     
     - returns: `CORSConfiguration`
     */
    func bucketCors(bucket: String) async throws -> CORSConfiguration {
        try await request(route: R2Route.bucketCors(bucket))
    }
    
    /**
     Create Bucket
     
     - parameter bucket:     Name of bucket
     - parameter location:   which zone (Default: "auto")
     */
    func createBucket(bucket: String, location: String = "auto") async throws {
        let createConfig = CreateBucketConfiguration(locationConstraint: location)
        let body = try encoder.encode(createConfig)
        let urlRequest = try config.request(route:  R2Route.createBucket(bucket), body: body)
        _ = try await webService.session.data(for: urlRequest, delegate: nil)
    }
}

public extension R2Client {
    /**
     Returns some or all (up to 1,000) of the objects in a bucket with each request. You can use the request parameters as selection criteria to return a subset of the objects in a bucket.
     
     - parameter bucket:     The bucket name containing the objects.
     - parameter parameters: parameters (Default: nil) `list-type, continuation-token, delimiter, encoding-type, fetch-owner, max-keys, prefix, start-after`
     
     - returns: `ListBucketResult` List of Objects
     */
    func listObjects(bucket: String, parameters: [String: String?]? = nil) async throws -> ListBucketResult {
        try await request(route: R2Route.objects(bucket))
     }
    
    /**
     Retrieves objects from Cloudflare R2.
     
     - parameter name:       The object name to get
     - parameter bucket:     The bucket name containing the object.
     - parameter parameters: parameters (Default: nil) `partNumber, response-cache-control,response-content-disposition,response-content-encoding,response-content-language,response-content-type,response-expires,versionId`

     - returns: `Data`
     */
    func getObject(name: String, fromBucket bucket: String, parameters: [String: String?]? = nil) async throws -> Data {
        try await data(route: R2Route.getObject(name, bucket))
    }
    
    /**
     Adds an object to a bucket.
     
     - parameter name:       The object name to get
     - parameter bucket:     The bucket name containing the object.
     - parameter object:     The object we need to put
     - parameter type:       Type of object
     
     */
    func putObject(name: String, toBucket bucket: String, object: Data, type: UTType) async throws {
        let header = HTTPHeader(name: URLRequest.Header.contentType, value: type.preferredMIMEType ?? type.identifier)
        let urlRequest = try config.request(route: R2Route.putObject(name, bucket), headers: [header], body: object)
        _ = try await webService.session.data(for: urlRequest, delegate: nil)
    }
}
