//
//  File.swift
//
//
//  Created by Waqar Malik on 12/24/22.
//

import Foundation

public enum R2Error: LocalizedError {
    case notFound

    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "Object not found on sever"
        }
    }
}
