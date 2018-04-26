//
//  TorrentListBond.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 18/08/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Bond

class BaseTableViewBond<DataSource: DataSourceProtocol> : DefaultTableViewBond<DataSource> {
    
    private var iterationsCount = 0;
    
    override init() {
        super.init()
        self.insertAnimation = nil
        self.deleteAnimation = nil
    }
    
    override func cellForRow(at index: Int, tableView: NSTableView, dataSource: DataSource) -> NSView? {
        let columnIndex = self.iterationsCount % tableView.tableColumns.count;
        self.iterationsCount += 1;
        
        return cellForRow(at: index, columnIndex: columnIndex, tableView: tableView, dataSource: dataSource)
    }
    
    open func cellForRow(at index: Int, columnIndex: Int, tableView: NSTableView, dataSource: DataSource) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: tableView.tableColumns[columnIndex].identifier, owner: nil) as? NSTableCellView {
            return cell
        }
        
        return nil
    }
}
