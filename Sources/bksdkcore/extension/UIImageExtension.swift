//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit

public extension UIImage {
    convenience init?(named: String, find api: BKApiFlow) {
        self.init(named: named, in: api.bundle, compatibleWith: nil)
    }
    
    var imageRendering: UIImage {
        self.withRenderingMode(.alwaysTemplate)
    }
}
