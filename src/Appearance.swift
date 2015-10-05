//
//  Appearance.swift
//  SCFD
//
//  Created by woof woof on 9/23/15.
//  Copyright © 2015 me. All rights reserved.
//

import UIKit

class Appearance: NSObject {
    
    class func setUp() {
        tabBar()
        navigationBar()
        barButtonItem()
    }
    
    class func tabBar() {
        UITabBar.appearance().barTintColor = Color.backgroundColor
        UITabBarItem.appearance().setTitleTextAttributes(Attributes.text, forState: .Normal)
    }
    
    class func navigationBar() {
        UINavigationBar.appearance().barTintColor = Color.backgroundColor
        UINavigationBar.appearance().titleTextAttributes = Attributes.text
    }
    
    class func barButtonItem() {
    }
    
}

struct Color {
    static let backgroundColor = UIColor.darkGrayColor()
    static let textColor = UIColor.whiteColor()
}

struct Attributes {
    static let text = [NSForegroundColorAttributeName: Color.textColor]
}