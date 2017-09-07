//
//  RequestArguments.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 30/06/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import ObjectMapper

class RequestArguments : Mappable {
    var fields : [TransmissionTorrentFields]?
    var ids : [Int]?
    
    init (){        
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        fields <- (map["fields"], EnumTransform<TransmissionTorrentFields>())
        ids <- map["ids"]
    }
}
