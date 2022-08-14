//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import ghmjolnircore

open class BKBaseViewController: UIViewController, GHBaseViewControllerDelegate {
    public var controllerType: Int?
    public var bundle: GHBundleParameters?
    public var viewModel: GHBaseViewModelProtocol?
    public var controllerManager: GHManagerController?
    
    open override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    open override var prefersStatusBarHidden: Bool { false }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        GHCacheImage.shared.releaseCache()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint("✅✅✅ \(self.description) ✅✅✅")
    }
    
    open func removeReferenceContext() {
        self.bundle = nil
        self.controllerType = nil
        self.controllerManager = nil
        self.viewModel = nil
    }
}
