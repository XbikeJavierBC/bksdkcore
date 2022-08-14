//
//  File.swift
//  
//
//  Created by Javier Carapia on 13/08/22.
//

import UIKit
import ghgungnircore
import ghmjolnircore

public protocol BKSdkApiManagerProtocol {
    static var flows: [GHManagerModel] { get set }
}

public class BKSdkApiManager {
    public static var shared: BKSdkApiManager = {
        let instance = BKSdkApiManager()
        return instance
    }()
    
    private static var apiList: [GHManagerModel] = [
        GHManagerModelBuilder()
            .withBundle(bundle: .module)
            .withType(type: BKApiFlow.sdk.rawValue)
            .build()
    ]
    
    private init() {
        UIFont.loadMyFonts
    }
    
    internal static func findRegisterApi(type: BKApiFlow) -> GHManagerModel? {
        return self.apiList.filter { $0.type == type.rawValue }.first
    }
    
    public func registerApi(_ managerModel: BKSdkApiManagerProtocol.Type) -> BKSdkApiManager {
        var list: [GHManagerModel] = []
        
        managerModel.flows.forEach { outModel in
            if !BKSdkApiManager.apiList.contains(where: { inModel in outModel.type == inModel.type }) {
                list.append(outModel)
            }
        }
        
        if list.isNotEmpty {
            BKSdkApiManager.apiList.append(contentsOf: list)
        }
        
        return self
    }
    
    public func registerApis(_ managerModelList: [BKSdkApiManagerProtocol.Type]) -> BKSdkApiManager {
        managerModelList.forEach {
            var list: [GHManagerModel] = []
            
            $0.flows.forEach { outModel in
                if !BKSdkApiManager.apiList.contains(where: { inModel in outModel.type == inModel.type }) {
                    list.append(outModel)
                }
            }
            
            if list.isNotEmpty {
                BKSdkApiManager.apiList.append(contentsOf: list)
            }
        }
        return self
    }
    
    public func build() {
        print("End Register BKSdkApiManager")
    }
}
