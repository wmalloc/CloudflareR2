import XCTest
@testable import R2
import XMLCoder
import WebServiceURLMock

final class R2Tests: XCTestCase {
    func testListBucketResult() throws {
        let data = try Bundle.module.data(forResource: "ListAllMyBucketsResult", withExtension: "xml", subdirectory: "TestData")
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        let buckets = try decoder.decode(ListAllMyBucketsResult.self, from: data)
        print(buckets)
    }
}
