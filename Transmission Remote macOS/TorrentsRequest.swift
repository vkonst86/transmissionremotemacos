//
//  TorrentsRequest.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 30/06/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import ObjectMapper

class TorrentsRequest : BaseRequest {
    var arguments : RequestArguments?
    
    init(with fields: [TransmissionTorrentFields]) {
        super.init()
        self.method = .torrentGet
        self.arguments = RequestArguments()
        self.arguments?.fields = fields
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        arguments <- map["arguments"]       
    }
}
