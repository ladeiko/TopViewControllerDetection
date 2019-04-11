//
//  UIApplication+TopViewControllerDetection.swift
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//

public typealias TopViewControllerDetectionAsyncCompletion = (_ viewController: UIViewController?) -> Void
        
extension UIApplication {

    @objc
    open func topViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topViewController()
    }
    
    @objc
    open func topViewController(_ completion: @escaping TopViewControllerDetectionAsyncCompletion) {
        self.keyWindow?.rootViewController?.topViewController(completion)
    }
    
}
