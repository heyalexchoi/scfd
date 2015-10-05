//
//  WindowController.swift
//  WeLive
//
//  Created by Scott Penrose on 9/20/15.
//  Copyright © 2015 WeWork. All rights reserved.
//

import UIKit

class WindowController {
    
    let window = UIWindow()
    
    init() {
        presentHome()
    }
    
    deinit {

    }
    
    // MARK: -
    
    
    func presentHome() {
        
        let vc = HomeViewController()
        vc.tabBarItem = UITabBarItem(title: "Main", image: nil, selectedImage: nil)
        
        let viewControllers = [vc].map { return UINavigationController(rootViewController: $0) }
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        
        window.rootViewController = tabBarController
    }
    
}
