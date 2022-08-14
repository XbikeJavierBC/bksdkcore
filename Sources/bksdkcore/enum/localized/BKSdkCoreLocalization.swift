//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import Foundation

public enum BKSdkCoreLocalization: String {
    case accept
    case error
    case start
    case stop
   
    public var localize: String {
        self.localizedString(
            key: self
        )
    }

    private func localizedString(key: BKSdkCoreLocalization) -> String {
        NSLocalizedString(
            key.rawValue,
            tableName: "bksdkcore",
            bundle: .module,
            comment: key.rawValue
        )
    }
}
