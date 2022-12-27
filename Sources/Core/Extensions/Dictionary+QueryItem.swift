//
//  Dictionary+QueryItem.swift
//  
//
//  Created by Waqar Malik on 12/26/22.
//

import Foundation

extension Dictionary where Key == String, Value == String? {
    var queryItems: [URLQueryItem] {
        self.reduce([]) { partialResult, parameter in
            var result = partialResult
            let item = URLQueryItem(name: parameter.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? parameter.key,
                                    value: parameter.value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            result.append(item)
            return result
        }
    }
}
