//
//  TorrentListViewModel.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 17/06/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class TorrentListViewModel : NSObject {
    private let transmissionService : TransmissionProtocol = TransmissionService(baseUrl: "http://192.168.1.2:9091")
    
    let filteredTorrents = MutableObservableArray<TorrentModel>([])
    let torrentCategories = MutableObservableArray<TorrentCategoryModel>([])
    let torrentFiles = MutableObservableArray<FileModel>([])
    let torrentPeers = MutableObservableArray<PeerModel>([])
    let selectedTorrentIndex = Observable<IndexSet>(IndexSet())
    let selectedCategoryIndex = Observable<IndexSet>(IndexSet())
    let selectedTorrentControlButtonIndex = Observable<Int>(-1)
    
    var torrents = [TorrentModel]()
    var selectedCategory : TorrentCategoryModel?
    var selectedTorrent : TorrentModel?
    
    override init(){
        super.init()
        self.torrentCategories.insert(contentsOf: self.getCategories(), at: 0)
        self.selectedCategory = self.torrentCategories[0]
        
        self.selectedTorrentControlButtonIndex.observeNext { selectedSegment in
            if (selectedSegment < 0){
                return
            }
            
            self.torrentControlsButtonPressed(index: selectedSegment)
        }.dispose(in: selectedTorrentControlButtonIndex.disposeBag)
        
        self.selectedTorrentIndex.observeNext { indexSet in
            if let index = indexSet.first{
                
                if self.filteredTorrents.count == 0 {
                    return
                }
                
                self.selectedTorrent = self.filteredTorrents[index]
                
                self.torrentFiles.removeAll()
                self.torrentPeers.removeAll()
                
                if let selectedTorrent = self.selectedTorrent {
                    self.torrentFiles.insert(contentsOf: selectedTorrent.files, at: 0)
                    self.torrentPeers.insert(contentsOf: selectedTorrent.peers, at: 0)
                }
            }
        }.dispose(in: selectedTorrentIndex.disposeBag)
        
        self.selectedCategoryIndex.observeNext { indexSet in
            if let index = indexSet.first {
                self.selectedCategory = self.torrentCategories[index]
                self.filteredTorrents.replace(with: self.filter(torrents: self.torrents, with: self.selectedCategory), performDiff: false)
                if self.filteredTorrents.count > 0 {
                    self.selectedTorrentIndex.value = IndexSet(integer: 0)
                }
            }
        }.dispose(in: selectedCategoryIndex.disposeBag)
        
    
        transmissionService.connect { isSuccess in
            if isSuccess {
                let timer = Timer.init(timeInterval: 2, repeats: true, block: {_ in
                    self.loadAllTorrents()
                })
                timer.fire()
                RunLoop.main.add(timer, forMode: .commonModes)
            }
        }
    }
    
    private func torrentControlsButtonPressed(index: Int){
        if (self.selectedTorrent == nil){
            return
        }
        
        switch index {
        case 1:
            self.transmissionService.startTorrent(id: self.selectedTorrent!.id)
            break
        case 2:
            self.transmissionService.stopTorrent(id: self.selectedTorrent!.id)
            break
        default:
            break
        }
    }
    
    private func filter(torrents: [TorrentModel], with category: TorrentCategoryModel?) -> [TorrentModel]
    {
        guard (category != nil || !(category!.category == .all)) else {
            return torrents
        }
        
        return torrents.filter { model in
            model.categories.contains(category!.category)
        }
    }
    
    private func loadAllTorrents()
    {
        transmissionService.getTorrentsList {
            torrentList in
            if let torrentList = torrentList{
                
                self.torrents = torrentList.map({ model in
                    for i in 0 ..< model.files.count {
                        model.files[i].isWanted = model.fileStats[i].wanted
                        model.files[i].priority = model.fileStats[i].priority
                    }
                    
                    return model
                })
                
                self.filteredTorrents.replace(with: self.filter(torrents: self.torrents, with: self.selectedCategory), performDiff: true)
                
                self.selectedTorrentIndex.value = self.selectedTorrentIndex.value
            }
        }
    }
    
    private func getCategories() -> [TorrentCategoryModel]{
        var categories : [TorrentCategoryModel] = []
        categories.append(TorrentCategoryModel(with: "All", category: .all))
        categories.append(TorrentCategoryModel(with: "Downloading", category: .downloading))
        categories.append(TorrentCategoryModel(with: "Completed", category: .completed))
        categories.append(TorrentCategoryModel(with: "Stopped", category: .stopped))
        categories.append(TorrentCategoryModel(with: "Active", category: .active))
        categories.append(TorrentCategoryModel(with: "Inactive", category: .inactive))
        
        return categories
    }
}
