//
//  TorrentModel.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 17/06/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import ObjectMapper

class TorrentModel : NSObject, Mappable {
    var id : Int = 0
    var name : String = ""
    var percentDone : Double = 0
    var dateCreated : Date = Date()
    var eta : Int = 0
    var rateDownload : Int = 0
    var rateUpload : Int = 0
    var totalSize : Int = 0
    var status : Int = 0
    var categories = [TorrentCategory]()
    var files = [FileModel]()
    var fileStats = [FileStatsModel]()
    var peers = [PeerModel]()
    
    required init?(map: Map){        
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        percentDone <- map["percentDone"]
        dateCreated <- (map["dateCreated"], DateTransform())
        eta <- map["eta"]
        rateDownload <- map["rateDownload"]
        rateUpload <- map["rateUpload"]
        totalSize <- map["totalSize"]
        status <- map["status"]
        files <- map["files"]
        fileStats <- map["fileStats"]
        peers <- map["peers"]
        
        categories.append(.all)
        
        if (rateDownload == 0 && rateUpload == 0){
            categories.append(.inactive)
        }
        else {
            categories.append(.active)
        }
        
        switch self.status {
        case 0:
            categories.append(.stopped)
        case 4:
            categories.append(.downloading)
        case 6:
            categories.append(.completed)
        default:
            break
        }

    }
}

class TorrentResponse : Mappable {
    var torrents : [TorrentModel]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        torrents <- map["arguments.torrents"]
    }
}
