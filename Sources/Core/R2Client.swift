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
    public let config: R2Config
    public let webService: WebService
    
    /**
     Default Intializer for the client

     - parameter config:             Configuration with keys and account id
     - parameter webService:         WebServer object if you want a custom
     */
    public init(config: R2Config, webService: WebService = WebService(session: .shared)) {
        self.config = config
        self.webService = webService
        R2Route.accountId = config.accountId
    }
    
    /**
     Return raw data

     - parameter route:      where to get the data
     - parameter parameters: If you need to add extra query parmeters to the query (Default: nil)
     - parameter headers:    extra headers (Default: nil)
     - parameter completion: completion handler
     
     - returns: Data Task which can be canceled
     */
    public func data(route: URLRequestRoutable, parameters: [String: String?]? = nil, headers: [HTTPHeader]? = nil, body: Data? = nil, completion: ((Result<Data, Error>) -> Void)?) -> URLSessionDataTask? {
        guard let request = try? config.request(route: route, parameters: parameters, headers: headers, body: body) else {
            return nil
        }
        return webService.dataTask(with: request) { (response) -> Data in
            response.data
        } completion: { result in
            completion?(result)
        }
    }
    
    /**
     Return decoded data object

     - parameter route:      where to get the data
     - parameter parameters: If you need to add extra query parmeters to the query (Default: nil)
     - parameter headers:    extra headers (Default: nil)
     - parameter completion: completion handler
     
     - returns: Data Task which can be canceled
     */
    public func request<T: Decodable>(route: URLRequestRoutable, parameters: [String: String?]? = nil, headers: [HTTPHeader]? = nil, completion: ((Result<T, Error>) -> Void)?) -> URLSessionDataTask? {
        guard let request = try? config.request(route: route, parameters: parameters, headers: headers) else {
            return nil
        }
        return webService.dataTask(with: request) { (response) -> T in
            let decoder = XMLDecoder()
            decoder.shouldProcessNamespaces = true
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: response.data)
        } completion: { result in
            completion?(result)
        }
    }
}
