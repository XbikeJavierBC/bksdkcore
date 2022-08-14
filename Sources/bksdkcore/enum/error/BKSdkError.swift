//
//  File.swift
//  
//
//  Created by Javier Carapia on 13/08/22.
//

import Foundation

public enum BKSdkError: Error {
    case apiNotFound(BKApiFlow)
    case apiNotFindClassFound(BKApiFlow)
    
    public var description: String {
        switch self {
            case .apiNotFound(let api):
                return "API \(api) was not found"
            case .apiNotFindClassFound(let api):
                return "Find Class API \(api) was not found"
        }
    }
}
