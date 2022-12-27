import XCTest
@testable import R2
import XMLCoder
import WebServiceURLMock

final class R2Tests: XCTestCase {
    let rfc3339DateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    func testListBucketResult() throws {
        let data = try Bundle.module.data(forResource: "ListAllMyBucketsResult", withExtension: "xml", subdirectory: "TestData")
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(rfc3339DateFormatter)
        let buckets = try decoder.decode(ListAllMyBucketsResult.self, from: data)
        XCTAssertEqual(2, buckets.buckets.buckets.count)
    }
    
    func testListBucketResultSample1() throws {
        let data = try Bundle.module.data(forResource: "ListBucketResultSample1", withExtension: "xml", subdirectory: "TestData")
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(rfc3339DateFormatter)
        let result = try decoder.decode(ListBucketResult.self, from: data)
        XCTAssertEqual(result.name, "bucket")
    }
    
    func testListBucketResultSample2() throws {
        let data = try Bundle.module.data(forResource: "ListBucketResultSample2", withExtension: "xml", subdirectory: "TestData")
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(rfc3339DateFormatter)
        let result = try decoder.decode(ListBucketResult.self, from: data)
        XCTAssertEqual(result.name, "quotes")
    }
    
    func testListBucketResultSample3() throws {
        let data = try Bundle.module.data(forResource: "ListBucketResultSample3", withExtension: "xml", subdirectory: "TestData")
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(rfc3339DateFormatter)
        let result = try decoder.decode(ListBucketResult.self, from: data)
        XCTAssertEqual(result.name, "example-bucket")
    }
    
    func testListBucketResultSample4() throws {
        let data = try Bundle.module.data(forResource: "ListBucketResultSample4", withExtension: "xml", subdirectory: "TestData")
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(rfc3339DateFormatter)
        let result = try decoder.decode(ListBucketResult.self, from: data)
        XCTAssertEqual(result.name, "example-bucket")
    }
}
