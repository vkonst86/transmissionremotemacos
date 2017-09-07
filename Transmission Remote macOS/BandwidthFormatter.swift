//
//  BandwidthFormatter.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 02/09/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation

public class BandwidthFormatter : Formatter {
    
    let byteCountFormatter = ByteCountFormatter()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    public override func string(for obj: Any?) -> String? {
        guard let speed = obj as? Int else {
            return ""
        }
        
        if speed <= 0 {
            return ""
        }
        
        let formattedSpeed = byteCountFormatter.string(fromByteCount: Int64(speed))
        return "\(formattedSpeed)/s"
    }
}
