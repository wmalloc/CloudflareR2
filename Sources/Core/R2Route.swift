//
//  R2Route.swift
//
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation
import WebService

public protocol URLRequestEncodable {
    func url(queryItems: [URLQueryItem]?) throws -> URL
    func urlRequest(queryItems: [URLQueryItem]?, headers: [HTTPHeader]?) throws -> URLRequest
}

public protocol URLRequestRoutable: URLRequestEncodable {
    static var apiBaseURLString: String { get set }
    var method: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var headers: [HTTPHeader] { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
}

public enum R2Route: URLRequestRoutable {
    public static var apiBaseURLString: String = "r2.cloudflarestorage.com"
    public static var accountId: String = ""
    
    case buckets
    case bucketCors(String)
    
    case objects(String)

    public var method: HTTPMethod {
        switch self {
        case .buckets:
            return .GET
        case .bucketCors:
            return .GET
        case .objects:
            return .GET
        }
    }
    
    public var host: String {
        let host = "\(Self.accountId).\(Self.apiBaseURLString)"
        switch self {
        case .buckets:
            return host
        case .bucketCors(let bucket):
            return bucket + "." + host
        case .objects(let bucket):
            return bucket + "." + host
        }
    }
    
    public var path: String {
        switch self {
        case .buckets, .bucketCors, .objects:
            return ""
        }
    }
    
    public var headers: [HTTPHeader] {
        let allHeaders: [HTTPHeader] = []
        switch self {
        case .buckets, .objects:
            return allHeaders
        case .bucketCors:
            return allHeaders
        }
    }
    
    public var body: Data? {
        switch self {
        case .buckets, .objects:
            return nil
        case .bucketCors:
            return nil
        }
    }
    
    public var queryItems: [URLQueryItem]? {
         switch self {
        case .buckets:
            return nil
        case .bucketCors:
             return [URLQueryItem(name: "cors", value: nil)]
         case .objects:
             return [URLQueryItem(name: "list-type", value: "2")]
        }
    }
}

extension R2Route: URLRequestEncodable {
    public func url(queryItems: [URLQueryItem]? = nil) throws -> URL {
        var components = URLComponents()
        components = components
            .setScheme("https")
            .setHost(host)
            .setPath(path)
            .setQueryItems(self.queryItems ?? [])
            .appendQueryItems(queryItems ?? [])

        guard let url = components.url else {
            throw URLError(.unsupportedURL)
        }
        return url
    }
    
    public func urlRequest(queryItems: [URLQueryItem]? = nil, headers: [HTTPHeader]? = nil) throws -> URLRequest {
        return URLRequest(url: try url(queryItems: queryItems))
            .setMethod(method)
            .setHttpBody(body)
            .setHeaders(self.headers)
            .setHeaders(headers)
    }
}
