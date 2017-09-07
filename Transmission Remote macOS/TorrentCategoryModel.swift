//
//  TorrentCategoryModel.swift
//  Transmission Remote macOS
//
//  Created by Vladimir Konstantinov on 14/07/2017.
//  Copyright © 2017 Vladimir Konstantinov. All rights reserved.
//

import Foundation

class TorrentCategoryModel : NSObject {
    var name : String
    var category : TorrentCategory
    
    init(with name: String, category: TorrentCategory){
        self.name = name
        self.category = category
    }
}
