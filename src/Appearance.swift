//
//  Appearance.swift
//  SCFD
//
//  Created by woof woof on 9/23/15.
//  Copyright © 2015 me. All rights reserved.
//

import UIKit
import Chameleon

class Appearance: NSObject {
    
    class func setUp() {
        tabBar()
        navigationBar()
        barButtonItem()
    }
    
    class func tabBar() {
        UITabBar.appearance().barTintColor = Color.Background.value
        UITabBarItem.appearance().setTitleTextAttributes(Attributes.text, forState: .Normal)
    }
    
    class func navigationBar() {
        UINavigationBar.appearance().barTintColor = Color.PrimaryForeground.value
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Color.Background.value]
    }
    
    class func barButtonItem() {
        
    }
    
}

protocol StyleValue {}
extension UIColor: StyleValue {}
extension UIFont: StyleValue {}

enum Color: StyleEnum {
    
    case Background
    case PrimaryForeground
    case SecondaryForeground
    
    var value: UIColor {
        switch self {
        case .Background:
            return UIColor.flatBlackColor()
        case .PrimaryForeground:
            return UIColor.flatWhiteColor()
        case .SecondaryForeground:
            return UIColor.flatOrangeColor()
        }
    }
    
    var name: String {
        switch self {
        case .Background:
            return "Background"
        case .PrimaryForeground:
            return "Primary Foreground"
        case .SecondaryForeground:
            return "Secondary Foreground"
        }
    }
    
    static var all: [StyleEnum] {
        return [Background, PrimaryForeground, SecondaryForeground]
    }
}


struct Attributes {
    static let text = [NSForegroundColorAttributeName: Color.PrimaryForeground.value]
}

protocol StyleEnum {
    static var all: [StyleEnum] { get }
}

extension UILabel {
    
    func setFont(font: Font) {
        self.font = font.value
    }
}

enum Font: StyleEnum {
    
    case Title1
    case Title2
    case Title3
    case Headline
    case Subheadline
    case Body
    case Footnote
    case Caption1
    case Caption2
    case Callout
    
    var value: UIFont {
        return UIFont.preferredFontForTextStyle(style)
    }
    
    var style: String {
        switch self {
        case .Title1:
            return UIFontTextStyleTitle1
        case .Title2:
            return UIFontTextStyleTitle2
        case .Title3:
            return UIFontTextStyleTitle3
        case .Headline:
            return UIFontTextStyleHeadline
        case .Subheadline:
            return UIFontTextStyleSubheadline
        case .Body:
            return UIFontTextStyleBody
        case .Footnote:
            return UIFontTextStyleFootnote
        case .Caption1:
            return UIFontTextStyleCaption1
        case .Caption2:
            return UIFontTextStyleCaption2
        case .Callout:
            return UIFontTextStyleCallout
        }
    }
    
    static var all: [StyleEnum] {
        return [Title1, Title2, Title3, Headline, Subheadline, Body, Footnote, Caption1, Caption2, Callout]
    }
    
    var name: String {
        return style.stringByReplacingOccurrencesOfString("UICTFontTextStyle", withString: "")
    }
}
