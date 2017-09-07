//
//  TorrentStartRequest.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 02/09/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import ObjectMapper

class TorrentStartRequest : BaseRequest {
    var arguments : RequestArguments?
    
    init(with id: Int) {
        super.init()
        self.method = .startTorrent
        self.arguments = RequestArguments()
        self.arguments!.ids = [id]
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        arguments <- map["arguments"]
    }
}
