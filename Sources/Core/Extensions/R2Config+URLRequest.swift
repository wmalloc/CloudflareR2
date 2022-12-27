//
//  R2Config+URLRequest.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation
import WebService

public extension R2Config {
    /**
     Signed URLRequest for R2
     
     - parameter route:      Route for which the request is generated
     - parameter parameters: Extra parameters
     - parameter headers:    Extra headers
     
     - returns: Signed URLRequest
     */
    func request(route: URLRequestRoutable, parameters: [String: String?]? = nil, headers: [HTTPHeader]? = nil, body: Data? = nil) throws -> URLRequest {
        try route.urlRequest(queryItems: parameters?.queryItems, headers: headers, body: body)
            .signed(config: self)
    }
}
