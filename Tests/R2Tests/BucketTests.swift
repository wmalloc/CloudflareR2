//
//  BucketTests.swift
//  
//
//  Created by Waqar Malik on 12/27/22.
//

import XCTest
@testable import R2
import XMLCoder
import WebServiceURLMock

final class BucketTests: XCTestCase {
    let decoder: XMLDecoder = {
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(R2Tests.rfc3339DateFormatter)
        return decoder
    }()
    
    func testCreateBucketBody() throws {
        let data =
        """
            <CreateBucketConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
             <LocationConstraint>Europe</LocationConstraint>
            </CreateBucketConfiguration >
        """.data(using: .utf8)
        XCTAssertNotNil(data)
        let createBucketConfig = try decoder.decode(CreateBucketConfiguration.self, from: data!)
        XCTAssertEqual(createBucketConfig.locationConstraint, "Europe")
    }
    
    func testListBucketResult() throws {
        let data = try Bundle.module.data(forResource: "ListAllMyBucketsResult", withExtension: "xml", subdirectory: "TestData")
        let buckets = try decoder.decode(ListAllMyBucketsResult.self, from: data)
        XCTAssertEqual(2, buckets.buckets.buckets.count)
    }
}
