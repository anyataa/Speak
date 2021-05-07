//
//  ColorExtension.swift
//  speak
//
//  Created by Anya Akbar on 29/04/21.
//

import Foundation
import UIKit

public extension UIColor {
    static let yellow = UIColor(named: "Primary")
    static let green = UIColor(named: "Secondary")
    static let background = UIColor(named: "Background")
    static let bold = UIColor(named: "Bold")
}

public extension UIFont {
    static var primaryBig = UIFont(name: "BalooChettan2-SemiBold", size: 34)
    
    static var primaryMed = UIFont(name: "BalooChettan2-SemiBold", size: 28)
    
    static func primary(size : CGFloat) -> UIFont {
        UIFont(name: "BalooChettan2-SemiBold", size: size) ?? UIFont(name: "BalooChettan2-SemiBold", size: 28)!
    }
    
    static func Bold(size : CGFloat) -> UIFont {
        UIFont(name: "BalooChettan2-ExtraBold", size: size) ?? UIFont(name: "BalooChettan2-ExtraBold", size: 28)!
    }
    
    static func Regular(size : CGFloat) -> UIFont {
        UIFont(name: "BalooChettan2-SemiBold", size: size) ?? UIFont(name: "BalooChettan2-SemiBold", size: 28)!
    }
    
    
}
