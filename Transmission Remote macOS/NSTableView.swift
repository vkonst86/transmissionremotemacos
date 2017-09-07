//
//  NSTableView.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 17/08/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

public extension ReactiveExtensions where Base : NSTableView {
    
    public var selectedIndexes: DynamicSubject2<IndexSet, ReactiveKit.NoError> {
        return dynamicSubject(
            signal: selectionDidChange,
            get: { (tableView) -> IndexSet in
                if let tableView = tableView as NSTableView? {
                    return tableView.selectedRowIndexes
                }
        },
            set: { (tableView, value) in
                if let tableView = tableView as NSTableView? {
                    tableView.selectRowIndexes(value, byExtendingSelection: false)
                }
        })
    }
}
