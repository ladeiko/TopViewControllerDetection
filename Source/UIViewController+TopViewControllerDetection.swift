//
//  UIViewController+TopViewControllerDetection.swift
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//

fileprivate func findTopViewController(_ base: UIViewController?) -> UIViewController? {
    
    guard let base = base else {
        return nil
    }
    
    #if swift(>=4.2)
    let children = base.children
    #else
    let children = base.childViewControllers
    #endif
    
    if let nav = base as? UINavigationController {
        return findTopViewController(nav.visibleViewController)
    }
    else if let tab = base as? UITabBarController {
        if let selectedViewController = tab.selectedViewController {
            return findTopViewController(selectedViewController)
        }
    }
    else if let presentedViewController = base.presentedViewController {
        return findTopViewController(presentedViewController);
    }
    else if children.isEmpty == false {
        if let lastViewController = children.reversed().filter({ (vc) -> Bool in
            return vc.isViewLoaded
                && (vc.view.isHidden == false)
                && (vc.view.alpha >= 0.05)
                && (base.view.bounds == vc.view.frame)
        }).first {
            return findTopViewController(lastViewController);
        }
    }
    
    return base
}
        
extension UIViewController {

    @objc
    open func topViewController() -> UIViewController? {
        return findTopViewController(self)
    }
    
    @objc
    open func topViewController(_ completion: @escaping TopViewControllerDetectionAsyncCompletion) {
        
        guard let viewController = findTopViewController(self) else {
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
                self.topViewController(completion)
            }
            return
        }
        
        DispatchQueue.main.async {
            completion(viewController)
        }
    }
    
}
