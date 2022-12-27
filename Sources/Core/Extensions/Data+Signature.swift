//
//  Data+Signature.swift
//  
//
//  Created by Waqar Malik on 12/25/22.
//

import Foundation
import CryptoKit

extension Data {
    var sha256: String {
        let h = SHA256.hash(data: self)
        return h.compactMap { String(format: "%02x", $0) }.joined()
    }
}
