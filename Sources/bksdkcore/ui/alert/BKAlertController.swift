//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit

public struct BKAlertController {
    public static func simple(
        title: String = "XBike",
        message: String,
        controller: UIViewController?,
        closure: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: BKSdkCoreLocalization.accept.localize, style: .default, handler: { action in
                    closure?()
                }
            )
        )
        
        controller?.present(alert, animated: true, completion: nil)
    }
    
    public static func error(
        message: String,
        controller: UIViewController?,
        closure: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: BKSdkCoreLocalization.error.localize, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: BKSdkCoreLocalization.accept.localize, style: .default, handler: { action in
                    closure?()
                }
            )
        )
        
        controller?.present(alert, animated: true, completion: nil)
    }
}
