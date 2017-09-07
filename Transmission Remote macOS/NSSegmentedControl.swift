//
//  NSSegmentedControl.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 24/08/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

public extension ReactiveExtensions where Base : NSSegmentedControlReactive {
    
    public var selectedSegment: DynamicSubject2<Int, ReactiveKit.NoError> {
        return dynamicSubject(
            signal: selectedSegmentChanged,
            get: { (segmentedControl) -> Int in
                if let segmentedControl = segmentedControl as NSSegmentedControl? {
                    return segmentedControl.selectedSegment
                }
        },
            set: { (segmentedControl, value) in
                if let segmentedControl = segmentedControl as NSSegmentedControl? {                    
                    segmentedControl.selectSegment(withTag: value)
                }
        })
    }
    
    public var selectedSegmentChanged: SafeSignal<Void> {
        return NotificationCenter.default.reactive.notification(name: .NSSegemntedControlReactiveSelectionDidChange, object: base).eraseType()
    }
}
