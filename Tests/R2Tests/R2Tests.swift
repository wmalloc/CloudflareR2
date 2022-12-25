import XCTest
@testable import R2
import XMLCoder

final class R2Tests: XCTestCase {
    func testListBucketResult() throws {
        let result = """
        <?xml version= \"1.0\" encoding= \"UTF-8\"?>
        <ListAllMyBucketsResult xmlns= \"http://s3.amazonaws.com/doc/2006-03-01/\">
            <Buckets>
                <Bucket>
                    <CreationDate>2022-12-25T04:22:03.812Z</CreationDate>
                    <Name>images</Name>
                </Bucket>
                <Bucket>
                    <CreationDate>2022-12-25T04:23:03.352Z</CreationDate>
                    <Name>videos</Name>
                </Bucket>
            </Buckets>
            <Owner>
                <DisplayName>asdfasdfasdfasdfa</DisplayName>
                <ID>asdfasdfasdfasdfa</ID>
            </Owner>
        </ListAllMyBucketsResult>
        """
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        let note = try decoder.decode(ListAllMyBucketsResult.self, from: result.data(using: .utf8)!)
        print(note)
    }
}
