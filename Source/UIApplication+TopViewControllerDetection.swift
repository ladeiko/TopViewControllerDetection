//
//  UIApplication+TopViewControllerDetection.swift
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//
        
extension UIApplication {

    @objc
    open func topViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topViewController()
    }
    
}
