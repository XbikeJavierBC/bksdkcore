//
//  File.swift
//  
//
//  Created by Javier Carapia on 13/08/22.
//

import UIKit

public extension UIFont {
    //MARK: ::: REGULAR :::
    static var abelRegular12: UIFont {
        UIFont(name: "Abel-Regular", size: 12.0) ?? .systemFont(ofSize: 12.0)
    }
}

extension UIFont {
    private static func loadFontWith(name: String) {
        let frameworkBundle = BKApiFlow.sdk.bundle
        let pathForResourceString = frameworkBundle.path(forResource: name, ofType: "ttf")
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>? = nil

        if (CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false) {
            print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

    internal static let loadMyFonts: () = {
        //MARK: DMSans
        loadFontWith(name: "Abel-Regular")
    }()
}

