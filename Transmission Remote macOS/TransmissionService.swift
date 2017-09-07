//
//  TransmissionAPI.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 07/06/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Alamofire
import Bond
import AlamofireObjectMapper

enum TransmissionHeaders : String {
    case sessoinId = "X-Transmission-Session-Id"
}

enum TransmissionMethod : String {
    case sessionGet = "session-get"
    case torrentGet = "torrent-get"
    case startTorrent = "torrent-start"
    case stopTorrent = "torrent-stop"
}

enum TransmissionTorrentFields : String {
    case id = "id"
    case name = "name"
    case percentDone = "percentDone"
    case dateCreated = "dateCreated"
    case eta = "eta"
    case rateDownload = "rateDownload"
    case rateUpload = "rateUpload"
    case totalSize = "totalSize"
    case status = "status"
    case files = "files"
    case fileStats = "fileStats"
    case peers = "peers"
}

protocol TransmissionProtocol {
    func connect(completionHandler: @escaping (Bool)-> Void)
    func getTorrentsList(completionHandler: @escaping ([TorrentModel]?)-> Void)
    func startTorrent(id : Int)
    func stopTorrent(id : Int) 
}

class TransmissionService : TransmissionProtocol {
    
    private var transmissionBaseUrl: String
    private var sessionId : String = ""
    
    public var isConnected : Bool = false
    
    init(baseUrl: String) {
        transmissionBaseUrl = "\(baseUrl)/transmission/rpc"
    }
    
    private func getSessionId(completionHandler: @escaping (String?)-> Void) {
        
        var transmissionSessionId: String?
        
        request(getUrl(for: .sessionGet)).response { response in
            if let error = response.error{
                print(error.localizedDescription)
            }
            else if let httpResponse = response.response{
                transmissionSessionId = httpResponse.allHeaderFields[AnyHashable(TransmissionHeaders.sessoinId.rawValue)] as? String
            }
            
            completionHandler(transmissionSessionId)
        }
    }
    
    func connect(completionHandler: @escaping (Bool)-> Void) {
        getSessionId { tSessionId in
            guard let tSessionId = tSessionId else {
                completionHandler(false)
                return
            }
            
            self.isConnected = true
            self.sessionId = tSessionId
            completionHandler(true)
        }
    }
    
    func getTorrentsList(completionHandler: @escaping ([TorrentModel]?)-> Void) {
        
        let fields = [TransmissionTorrentFields.id,
                      TransmissionTorrentFields.dateCreated,
                      TransmissionTorrentFields.eta,
                      TransmissionTorrentFields.name,
                      TransmissionTorrentFields.percentDone,
                      TransmissionTorrentFields.rateDownload,
                      TransmissionTorrentFields.rateUpload,
                      TransmissionTorrentFields.totalSize,
                      TransmissionTorrentFields.status,
                      TransmissionTorrentFields.files,
                      TransmissionTorrentFields.fileStats,
                      TransmissionTorrentFields.peers]
        
        let torrentRequest = TorrentsRequest(with: fields)
        
        let headers = [
               TransmissionHeaders.sessoinId.rawValue : "\(sessionId)"
        ]
        debugPrint(torrentRequest.toJSON())
        request(transmissionBaseUrl, method: .post, parameters: torrentRequest.toJSON(), encoding: JSONEncoding.default, headers : headers).responseObject { (response: DataResponse<TorrentResponse>) in

            if let error = response.error{             
                print(error.localizedDescription)
            }
            else {
                debugPrint(response)
                completionHandler(response.result.value?.torrents)
            }
        }
    }
    
    func startTorrent(id : Int) {
        let headers = [
            TransmissionHeaders.sessoinId.rawValue : "\(sessionId)"
        ]
        
        let torrentStartRequest = TorrentStartRequest(with: id)
        
        request(transmissionBaseUrl, method: .post, parameters: torrentStartRequest.toJSON(), encoding: JSONEncoding.default, headers : headers).validate()
    }
    
    func stopTorrent(id : Int) {
        let headers = [
            TransmissionHeaders.sessoinId.rawValue : "\(sessionId)"
        ]
        
        let torrentStopRequest = TorrentStopRequest(with: id)
        
        request(transmissionBaseUrl, method: .post, parameters: torrentStopRequest.toJSON(), encoding: JSONEncoding.default, headers : headers).validate()
    }
    
    private func getUrl(for method : TransmissionMethod) -> String {
        switch method {
        default:
            return "\(transmissionBaseUrl)?method=\(method.rawValue)"
        }
    }
    
}
