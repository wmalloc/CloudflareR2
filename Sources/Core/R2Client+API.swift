//
//  R2Client+API.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation
import UniformTypeIdentifiers
import WebService

public extension R2Client {
    /**
     Returns a list of all buckets owned by the authenticated sender of the request.
     
     - parameter completion: Completion Handler
     
     - returns: Data Task which can be canceled
     */
    func listBuckets(completion: ((Result<ListAllMyBucketsResult, Error>) -> Void)?) -> URLSessionDataTask? {
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
    func listObjects(bucket: String, parameters: [String: String?]? = nil, completion: ((Result<ListBucketResult, Error>) -> Void)?) -> URLSessionDataTask? {
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
    func getObject(name: String, fromBucket bucket: String, parameters: [String: String?]? = nil, completion: ((Result<Data, Error>) -> Void)?) -> URLSessionDataTask? {
        data(route: R2Route.getObject(name, bucket), parameters: parameters, completion: completion)
    }
    
    /**
     Adds an object to a bucket.
     
     - parameter name:       The object name to get
     - parameter bucket:     The bucket name containing the object.
     - parameter object:     The object we need to put
     - parameter type:       Type of object
     - parameter completion: Completion Handler
     
     - returns: Data Task which can be canceled
     */
    func putObject(name: String, toBucket bucket: String, object: Data, type: UTType, completion: ((Error?) -> Void)?) -> URLSessionDataTask? {
        let header = HTTPHeader(name: URLRequest.Header.contentType, value: type.preferredMIMEType ?? type.identifier)
        guard let urlRequest = try? config.request(route: R2Route.putObject(name, bucket), headers: [header], body: object) else {
            return nil
        }
        let task = webService.session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion?(error)
                return
            }
            
            guard let response else {
                completion?(URLError(.badServerResponse))
                return
            }

            do {
                try response.ws_validate()
            } catch {
                completion?(error)
                return
            }
            completion?(nil)
        }
        task.resume()
        return task
    }
}
