//
//  R2Client+Combine.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation
import R2
import Combine
import WebService
import WebServiceCombine
import XMLCoder

public extension R2Client {
    /**
     Return raw data

     - parameter route:      where to get the data
     - parameter parameters: If you need to add extra query parmeters to the query (Default: nil)
     - parameter headers:    extra headers (Default: nil)
     
     - returns: Data Publisher
     */
    func data(route: URLRequestRoutable, parameters: [String: String?]? = nil, headers: [HTTPHeader]? = nil) -> AnyPublisher<Data, Error> {
        guard let request = try? config.request(route: route, parameters: parameters, headers: headers) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return webService.dataPublisher(for: request) { response in
            response.data
        }
    }
    
    /**
     Return decoded data object

     - parameter route:      where to get the data
     - parameter parameters: If you need to add extra query parmeters to the query (Default: nil)
     - parameter headers:    extra headers (Default: nil)
     
     - returns: Object publisher
     */
   func request<T: Decodable>(route: URLRequestRoutable, parameters: [String: String?]? = nil, headers: [HTTPHeader]? = nil) -> AnyPublisher<T, Error> {
        guard let request = try? config.request(route: route, parameters: parameters, headers: headers) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return webService.dataPublisher(for: request) { response in
            let decoder = XMLDecoder()
            decoder.shouldProcessNamespaces = true
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: response.data)
        }
    }
}

public extension R2Client {
    /**
     Returns a list of all buckets owned by the authenticated sender of the request.
     
     - returns: Publisher which can be canceled
     */
    func buckets() -> AnyPublisher<ListAllMyBucketsResult, Error> {
        request(route: R2Route.buckets)
    }
    
    /**
     Returns the Cross-Origin Resource Sharing (CORS) configuration information set for the bucket.
     
     - parameter bucket:     The bucket name for which to get the cors configuration.
     
     - returns: Publisher which can be canceled
     */
    func bucketCors(bucket: String) -> AnyPublisher<CORSConfiguration, Error> {
        request(route: R2Route.bucketCors(bucket))
    }
    
    /**
     Returns some or all (up to 1,000) of the objects in a bucket with each request. You can use the request parameters as selection criteria to return a subset of the objects in a bucket.
     
     - parameter bucket:     The bucket name containing the objects.
     - parameter parameters: parameters (Default: nil) `list-type, continuation-token, delimiter, encoding-type, fetch-owner, max-keys, prefix, start-after`
     
     - returns: Publisher which can be canceled
     */
    func objects(bucket: String, parameters: [String: String?]? = nil) -> AnyPublisher<ListBucketResult, Error> {
        request(route: R2Route.objects(bucket), parameters: parameters)
     }
    
    /**
     Retrieves objects from Cloudflare R2.
     
     - parameter name:       The object name to get
     - parameter bucket:     The bucket name containing the object.
     - parameter parameters: parameters (Default: nil) `partNumber, response-cache-control,response-content-disposition,response-content-encoding,response-content-language,response-content-type,response-expires,versionId`

     - returns: Publisher which can be canceled
     */
    func object(name: String, fromBucket bucket: String, parameters: [String: String?]? = nil) -> AnyPublisher<Data, Error> {
        data(route: R2Route.object(name, bucket), parameters: parameters)
    }
}
