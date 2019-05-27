//
//  UIApplication+TopViewControllerDetection.swift
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//

public typealias TopViewControllerDetectionAsyncCompletion = (_ viewController: UIViewController?) -> Void
        
extension UIApplication {

    @objc
    open func findTopViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.findTopViewController()
    }
    
    @objc
    open func findTopViewController(_ completion: @escaping TopViewControllerDetectionAsyncCompletion) {
        self.keyWindow?.rootViewController?.findTopViewController(completion)
    }
    
}
