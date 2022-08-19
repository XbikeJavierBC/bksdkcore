//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit

public extension UIViewController {
    //MARK: LEFT CONFIG NAV
    func addNavImageButtonLeft(imageLeft: UIImage?) {
        self.cleanNavButtonLeft()
        
        let imageButtonItem = UIBarButtonItem(
            image: imageLeft,
            style: .done,
            target: self,
            action: #selector(leftNavButtonSelector)
        )
        
        
        self.navigationItem.leftBarButtonItem = imageButtonItem
    }
    
    func addNavCustomButtonLeft(imageLeft: UIImage?) {
        self.cleanNavButtonLeft()
        
        let tempImage = imageLeft?.imageRendering
        
        var list: [UIBarButtonItem] = []
        
        let btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 35))
        btnProfile.setImage(tempImage, for: .normal)
        btnProfile.backgroundColor = .clear
        btnProfile.layer.masksToBounds = true
        btnProfile.addTarget(self, action: #selector(leftNavButtonSelector), for: .touchUpInside)
        btnProfile.tintColor = .white
        btnProfile.layer.cornerRadius = 12
        
        let imageButtonItem = UIBarButtonItem(customView: btnProfile)
        
        list.append(imageButtonItem)
        
        self.navigationItem.leftBarButtonItems = list
    }
    
    func addNavLeftProfileView(view: UIView) {
        self.cleanNavButtonLeft()
        
        let leftBarButton = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    //MARK: RIGHT CONFIG NAV
    func addNavImageButtonRight(image: UIImage?) {
        self.cleanNavButtonRight()
        
        var list: [UIBarButtonItem] = []
        
        let imageButtonItem = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(rightNavButtonSelector)
        )
        
        list.append(imageButtonItem)
        
        self.navigationItem.rightBarButtonItems = list
    }
    func addNavButtonRight(text: String) {
        self.cleanNavButtonRight()
        
        var list: [UIBarButtonItem] = []
        
        let imageButtonItem = UIBarButtonItem(
            title: text,
            style: .done,
            target: self,
            action: #selector(rightNavButtonSelector)
        )
        
        list.append(imageButtonItem)
        
        self.navigationItem.rightBarButtonItems = list
    }
    
    //MARK: NAV BAR STYLE
    func setWhiteBackStyle(color: UIColor, font: UIFont, fontRight: UIFont) {
        self.navigationController?.navigationBar.barStyle = .default
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [
                .foregroundColor: color,
                .font: fontRight
            ],
            for: .normal
        )
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.clear,
            .font: font
        ]
        
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        if let statusBar = UIApplication.shared.statusBarUIView {
            statusBar.backgroundColor = nil
        }
    }
    
    func setDarkBackStyle(color: UIColor, font: UIFont) {
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: color,
            .font: font
        ]
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        if let statusBar = UIApplication.shared.statusBarUIView {
            statusBar.backgroundColor = nil
        }
    }
    
    //MARK: CLEAN NAV
    func cleanNavigationBar() {
        self.cleanNavButtonLeft()
        self.cleanNavButtonRight()
    }
    
    func cleanNavButtonLeft() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItems = nil
    }
    
    func cleanNavButtonRight() {
        self.navigationItem.rightBarButtonItems = nil
    }
    
    //MARK: SELECTORS
    @objc open func leftNavButtonSelector() {
        if let controller = self as? BKBaseViewController {
            controller.controllerManager?.hideViewController()
        }
        else if let controller = self as? BKBaseTabBarViewController {
            controller.controllerManager?.hideViewController()
        }
        else if let controller = self as? BKBasePageViewController {
            controller.controllerManager?.hideViewController()
        }
    }
    
    @objc open func rightNavButtonSelector() { }
}

extension UIApplication {
    var statusBarUIView: UIView? {
        
        if #available(iOS 13.0, *) {
            let tag = 3848245
            
            let keyWindow = UIApplication.shared.connectedScenes
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows.first
            
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarView = UIView(frame: height)
                statusBarView.tag = tag
                statusBarView.layer.zPosition = 999999
                
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
            
        } else {
            
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}
