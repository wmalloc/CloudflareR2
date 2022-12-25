//
//  R2Client.swift
//
//
//  Created by Waqar Malik on 12/24/22.
//

import Foundation
import WebService

public class R2Client {
    let config: R2ClientConfig
    let webService: WebService
    
    public init(config: R2ClientConfig, webService: WebService = WebService(session: .shared)) {
        self.config = config
        self.webService = webService
    }
}
