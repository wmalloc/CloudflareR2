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
    
    public init(config: R2Config, webService: WebService = WebService(session: .shared)) {
        self.config = config
        self.webService = webService
        R2Route.accountId = config.accountId
    }
    
    public func request<T: Decodable>(route: URLRequestRoutable, completion: ((Result<T, Error>) -> Void)?) -> URLSessionDataTask? {
        guard let request = try? config.request(route: route) else {
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
