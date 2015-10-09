//
//  UIView+AutoLayout.swift
//  WeLive
//
//  Created by Scott Penrose on 9/27/15.
//  Copyright © 2015 WeWork. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWithVisualFormatStrings(formatStrings: [String], options: NSLayoutFormatOptions = [], metrics: [String: AnyObject] = [:], views: [String: AnyObject]) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        for formatString in formatStrings {
            constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat(formatString, options: options, metrics: metrics, views: views))
        }
        
        addConstraints(constraints)
        return constraints
    }
    
    func addSubviewWithAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func addSubviewsWithAutoLayout(views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func addSubviewsWithAutoLayout(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    /** Applies left inset to leading, and right inset to trailing */
    func anchorAllEdgesToView(view: UIView, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: insets.left).active = true
        trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -insets.right).active = true
        topAnchor.constraintEqualToAnchor(view.topAnchor, constant: insets.top).active = true
        bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -insets.bottom).active = true
    }
    /** Applies left inset to leading, and right inset to trailing. Top and bottom insets are ignored. */
    func anchorLeadingAndTrailingEdgesToView(view: UIView, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: insets.left).active = true
        trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -insets.right).active = true
    }
    /** Left and right insets are ignored. */
    func anchorTopAndBottomEdgesToView(view: UIView, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        topAnchor.constraintEqualToAnchor(view.topAnchor, constant: insets.top).active = true
        bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -insets.bottom).active = true
    }
    
    func anchorWidthAndHeightToSize(size: CGSize) {
        heightAnchor.constraintEqualToConstant(size.height).active = true
        widthAnchor.constraintEqualToConstant(size.width).active = true
    }
    
    func anchorHeightToConstant(height: CGFloat) {
        heightAnchor.constraintEqualToConstant(height).active = true
    }
    
    func anchorWidthToConstant(width: CGFloat) {
        widthAnchor.constraintEqualToConstant(width).active = true
    }
    
    func anchorTopToTopEdgeOfView(view: UIView, constant: CGFloat = 0) {
        topAnchor.constraintEqualToAnchor(view.topAnchor, constant: constant).active = true
    }
    
    func anchorBottomToBottomEdgeOfView(view: UIView, constant: CGFloat = 0) {
        bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: constant).active = true
    }
    
    func anchorLeftToLeftEdgeOfView(view: UIView, constant: CGFloat = 0) {
        leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: constant).active = true
    }
    
    func anchorRightToRightEdgeOfView(view: UIView, constant: CGFloat = 0) {
        rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: constant).active = true
    }
    
    func anchorBottomToTopEdgeOfView(view: UIView, constant: CGFloat = 0) {
        bottomAnchor.constraintEqualToAnchor(view.topAnchor, constant: constant).active = true
    }
    
    func anchorTopToBottomEdgeOfView(view: UIView, constant: CGFloat = 0) {
        topAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: constant).active = true
    }
    
    func anchorCenterToCenterOfView(view: UIView) {
        centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
    }
    
    func anchorCenterYToCenterYOfView(view: UIView) {
        centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
    }

    func anchorCenterXToCenterXOfView(view: UIView) {
        centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }

}
