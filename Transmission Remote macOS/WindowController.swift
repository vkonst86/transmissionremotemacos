//
//  WindowController.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 20/07/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Cocoa

class WindowController : NSWindowController, NSToolbarDelegate {
    @IBOutlet weak var toolbar: NSToolbar!
    
    @IBOutlet weak var torrentControls: NSSegmentedControlReactive!
    var viewController : ViewController!
    
    override func windowDidLoad() {
        self.window!.titleVisibility = .hidden
        self.viewController = self.contentViewController as! ViewController
    }
}
