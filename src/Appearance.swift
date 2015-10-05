//
//  Appearance.swift
//  WeLive
//
//  Created by Scott Penrose on 9/23/15.
//  Copyright © 2015 WeWork. All rights reserved.
//

import UIKit

class Appearance: NSObject {
    
    class func setUp() {
        tabBar()
        navigationBar()
        barButtonItem()
    }
    
    class func tabBar() {
        UITabBar.appearance().translucent = false
    }
    
    class func navigationBar() {
        UINavigationBar.appearance().translucent = false
    }
    
    class func barButtonItem() {
    }
    
}
