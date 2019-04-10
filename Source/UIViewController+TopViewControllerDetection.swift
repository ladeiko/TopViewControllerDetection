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
    else if base.children.isEmpty == false {
        if let lastViewController = base.children.reversed().filter({ (vc) -> Bool in
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
    
}
