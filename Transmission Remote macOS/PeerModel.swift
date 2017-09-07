//
//  PeerModel.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 01/08/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import ObjectMapper

class PeerModel : NSObject, Mappable {
    var address : String = ""
    var clientName : String = ""
    var download : Int = 0
    var upload : Int = 0
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        clientName <- map["clientName"]
        download <- map["rateToClient"]
        upload <- map["rateToPeer"]
    }
}
