//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit

public struct BKAppStyle {
    public static func setNavigationStyle(color: UIColor = .white, font: UIFont = .abelRegular20) {
        UINavigationBar.appearance().barStyle       = .blackTranslucent
        UINavigationBar.appearance().barTintColor   = .clear
        UINavigationBar.appearance().tintColor      = color
        UINavigationBar.appearance().isTranslucent  = true
        UINavigationBar.appearance().isOpaque       = true
        UINavigationBar.appearance().shadowImage    = UIImage()
        UINavigationBar.appearance().backgroundColor = nil
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: color,
            .font: font
        ]
        
        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: color,
            .font: font
        ]
    }
    
    public static func setTabBarStyle(color: UIColor, font: UIFont) {
        UITabBar.appearance().tintColor = color
        UITabBar.appearance().unselectedItemTintColor = .black
        UITabBar.appearance().isTranslucent  = true
        UITabBar.appearance().isOpaque       = true
        UITabBar.appearance().backgroundColor = .white
    }
}
