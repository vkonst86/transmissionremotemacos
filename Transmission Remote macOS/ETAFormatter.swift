//
//  ETAFormatter.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 02/09/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation
import Cocoa

public class ETAFormatter : Formatter {
    
    let dateFormatter = DateComponentsFormatter()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dateFormatter.allowedUnits.insert(NSCalendar.Unit.day)
        dateFormatter.allowedUnits.insert(NSCalendar.Unit.hour)
        dateFormatter.allowedUnits.insert(NSCalendar.Unit.minute)
        dateFormatter.allowedUnits.insert(NSCalendar.Unit.second)
        dateFormatter.unitsStyle = .abbreviated
        dateFormatter.allowsFractionalUnits = true        
    }
    
    public override func string(for obj: Any?) -> String? {
        guard let eta = obj as? Int else {
            return ""
        }
        
        if eta <= 0 {
            return ""
        }
        
        
        let dateComponents = DateComponents(second: eta)
        
        return dateFormatter.string(from: dateComponents)
    }
}
