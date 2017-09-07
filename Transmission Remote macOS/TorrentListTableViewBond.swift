//
//  TorrentListTableViewBond.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 18/08/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Bond

class TorrentListTableViewBond : BaseTableViewBond<ObservableArray<TorrentModel>> {
    
    let NumberCell = "NumberCellID"
    
    override func cellForRow(at index: Int, columnIndex: Int, tableView: NSTableView, dataSource: ObservableArray<TorrentModel>) -> NSView? {
        if let cell = super.cellForRow(at: index, columnIndex: columnIndex, tableView: tableView, dataSource: dataSource) as? NSTableCellView {
            if cell.identifier == NumberCell {
                cell.textField?.stringValue = String(index + 1)
            }
            return cell
        }
        
        return nil
    }
}
