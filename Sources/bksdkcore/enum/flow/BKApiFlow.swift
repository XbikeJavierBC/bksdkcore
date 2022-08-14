//
//  File.swift
//  
//
//  Created by Javier Carapia on 13/08/22.
//

import Foundation
import ghmjolnircore

public enum BKApiFlow: Int {
    case sdk
    
    case onboarding
    case extremelySimpleItemOnboarding
    case seeProgressItemOnboarding
    case trackTimeItemOnboarding
    case pageOnBoardingControl
    
    case currentRide
    
    case dashboard
}

public extension BKApiFlow {
    var modelManager: GHManagerModel {
        get throws {
            guard let manager = BKSdkApiManager.findRegisterApi(type: self) else {
                throw BKSdkError.apiNotFound(self)
            }
            
            return manager
        }
    }
    
    var controller: GHBaseViewControllerDelegate? {
        try! self.modelManager.delegate?.getController()
    }
    
    var viewModel: GHBaseViewModelProtocol? {
        try! self.modelManager.delegate?.getViewModel()
    }
    
    var bundle: Bundle {
        try! self.modelManager.bundle ?? .main
    }
}
