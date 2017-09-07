//
//  BaseRequest.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 29/06/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseRequest : Mappable {
    var method : TransmissionMethod?
    var tag : Int?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        method <- (map["method"], EnumTransform<TransmissionMethod>())
        tag <- map["tag"]
    }
}
