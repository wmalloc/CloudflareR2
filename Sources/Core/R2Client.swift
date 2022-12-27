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
    
    public let rfc3339DateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    public private(set) lazy var decoder: XMLDecoder = {
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(self.rfc3339DateFormatter)
        return decoder
    }()
    
    public private(set) lazy var encoder: XMLEncoder = {
        let encoder = XMLEncoder()
        encoder.dateEncodingStrategy = .formatted(self.rfc3339DateFormatter)
        return encoder
    }()
    
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
            decoder.dateDecodingStrategy = .formatted(self.rfc3339DateFormatter)
            return try decoder.decode(T.self, from: response.data)
        } completion: { result in
            completion?(result)
        }
    }
    
    public func request(route: URLRequestRoutable, parameters: [String: String?]? = nil, headers: [HTTPHeader]? = nil, body: Data? = nil, completion: ((Error?) -> Void)?) -> URLSessionDataTask? {
        guard let urlRequest = try? config.request(route: route, parameters: parameters, headers: headers, body: body) else {
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
