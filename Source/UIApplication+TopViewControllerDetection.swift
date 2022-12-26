//
//  UIApplication+TopViewControllerDetection.swift
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//

public typealias TopViewControllerDetectionAsyncCompletion = @MainActor (_ viewController: UIViewController?) -> Void
        
extension UIApplication {

    @MainActor @objc @discardableResult
    open func findTopViewController() -> UIViewController? {
        return keyWindow?.rootViewController?.findTopViewController()
    }
    
    @MainActor @objc
    open func findTopViewController(_ completion: @escaping TopViewControllerDetectionAsyncCompletion) {
        guard let keyWindow = self.keyWindow else {
            return DispatchQueue.main.async { completion(nil) }
        }
        keyWindow.rootViewController?.findTopViewController(completion)
    }

    @MainActor
    public func findTopViewControllerAsync() async -> UIViewController? {
        return await withCheckedContinuation({ continuation in
            findTopViewController { viewController in
                continuation.resume(returning: viewController)
            }
        })
    }
    
}
