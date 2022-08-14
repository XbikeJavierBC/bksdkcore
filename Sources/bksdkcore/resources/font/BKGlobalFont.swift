//
//  File.swift
//  
//
//  Created by Javier Carapia on 13/08/22.
//

import UIKit

public extension UIFont {
    //MARK: ::: REGULAR :::
    static var abelRegular15: UIFont {
        UIFont(name: "Abel-Regular", size: 15.0) ?? .systemFont(ofSize: 15.0)
    }
    static var abelRegular20: UIFont {
        UIFont(name: "Abel-Regular", size: 20.0) ?? .systemFont(ofSize: 20.0)
    }
    static var abelRegular25: UIFont {
        UIFont(name: "Abel-Regular", size: 25.0) ?? .systemFont(ofSize: 25.0)
    }
    static var abelRegular30: UIFont {
        UIFont(name: "Abel-Regular", size: 30.0) ?? .systemFont(ofSize: 30.0)
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

