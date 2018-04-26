//
//  ViewController.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 31/05/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Cocoa
import Alamofire
import Bond
import ReactiveKit

class ViewController: NSViewController {

    @IBOutlet weak var torrentsListTableView: NSTableView!
    @IBOutlet weak var categoriesListTableView: NSTableView!
    @IBOutlet weak var torrentFilesTableView: NSTableView!
    @IBOutlet weak var torrentPeersTableView: NSTableView!
    
    let viewModel = TorrentListViewModel()
    var torrentControls : NSSegmentedControlReactive!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        let windowController = NSApplication.shared.windows[0].windowController as! WindowController
        self.torrentControls = windowController.torrentControls
        
        viewModel.torrentCategories.bind(to: categoriesListTableView, using: BaseTableViewBond<ObservableArray<TorrentCategoryModel>>())
        viewModel.filteredTorrents.bind(to: torrentsListTableView, using: TorrentListTableViewBond())
        viewModel.torrentFiles.bind(to: torrentFilesTableView, using: BaseTableViewBond<ObservableArray<FileModel>>())
        viewModel.torrentPeers.bind(to: torrentPeersTableView, using: BaseTableViewBond<ObservableArray<PeerModel>>())
        
        viewModel.selectedTorrentIndex.bidirectionalBind(to: torrentsListTableView.reactive.selectedIndexes)
        viewModel.selectedCategoryIndex.bidirectionalBind(to: categoriesListTableView.reactive.selectedIndexes)
        //torrentControls.reactive.selectedSegment.bind(to: viewModel.selectedTorrentControlButtonIndex)
        
        viewModel.selectedTorrentControlButtonIndex.bidirectionalBind(to: torrentControls.reactive.selectedSegment)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
