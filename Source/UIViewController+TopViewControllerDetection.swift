//
//  UIViewController+TopViewControllerDetection.swift
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//

import UIKit

fileprivate func _findTopViewController(_ base: UIViewController?) -> UIViewController? {
    
    guard let base = base else {
        return nil
    }
    
    #if swift(>=4.2)
    let children = base.children
    #else
    let children = base.childViewControllers
    #endif
    
    if let nav = base as? UINavigationController {
        return _findTopViewController(nav.visibleViewController)
    }
    else if let tab = base as? UITabBarController {
        if let selectedViewController = tab.selectedViewController {
            return _findTopViewController(selectedViewController)
        }
    }
    else if let presentedViewController = base.presentedViewController {
        return _findTopViewController(presentedViewController);
    }
    else if children.isEmpty == false {
        if let lastViewController = children.reversed().filter({ (vc) -> Bool in
            return vc.isViewLoaded
                && (vc.view.isHidden == false)
                && (vc.view.alpha >= 0.05)
                && (base.view.bounds == vc.view.frame)
        }).first {
            return _findTopViewController(lastViewController);
        }
    }
    
    return base
}
        
extension UIViewController {

    @objc
    open func findTopViewController() -> UIViewController? {
        return _findTopViewController(self)
    }
    
    @objc
    open func findTopViewController(_ completion: @escaping TopViewControllerDetectionAsyncCompletion) {
        
        guard let viewController = _findTopViewController(self) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        #if swift(>=4.2)
        let busy = viewController.isBeingPresented || viewController.isBeingDismissed || viewController.isMovingToParent || viewController.isMovingFromParent
        #else
        let busy =  viewController.isBeingPresented || viewController.isBeingDismissed || viewController.isMovingToParentViewController || viewController.isMovingFromParentViewController
        #endif
        if busy {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1/60) {
                self.findTopViewController(completion)
            }
            return
        }
        
        DispatchQueue.main.async {
            completion(viewController)
        }
    }
    
}
