//
//  NSSegmentedControlReactive.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 31/08/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Cocoa
import Darwin

public class NSSegmentedControlReactive : NSSegmentedControl {

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.action = #selector(self.selectionChanged)
    }
    
    override public var action: Selector? {
        get{
            return super.action
        }
        set(value){
            super.target = self
            
            if (super.action != nil){
                return
            }
            
            super.action = value
        }
    }
    
    func selectionChanged () {
        NotificationCenter.default.post(name: NSNotification.Name.NSSegemntedControlReactiveSelectionDidChange, object: self)
    }
}

extension NSNotification.Name {
    public static let NSSegemntedControlReactiveSelectionDidChange = NSNotification.Name("NSSegemntedControlReactiveSelectionDidChange")
}
