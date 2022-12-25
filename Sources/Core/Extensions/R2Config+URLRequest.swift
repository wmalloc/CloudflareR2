//
//  File.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

public extension R2Config {
    func request(route: URLRequestRoutable) throws -> URLRequest {
        try route.urlRequest(queryItems: nil, headers: nil)
            .signed(config: self)
    }
}
