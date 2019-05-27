//
//  TopViewControllerDemoTests.swift
//  TopViewControllerDemoTests
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//

import Foundation
import XCTest
import TopViewControllerDetection

fileprivate func cleanup() {
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
    let viewController = storyboard.instantiateInitialViewController()
    UIApplication.shared.keyWindow?.rootViewController = viewController
}

typealias Completion = () -> Void

class TopViewControllerDemoTests: XCTestCase {
    
    func run(_ block: (_ complete: @escaping Completion) -> Void ) {
        
        let expectation = XCTestExpectation(description: "")
        
        block({ expectation.fulfill() })
        
        self.wait(for: [expectation], timeout: 100)
    }
    
    func test_SimpleViewController() {
        
        self.addTeardownBlock {
            cleanup()
        }
        
        XCTAssert(UIApplication.shared.keyWindow != nil)
        
        XCTAssert(UIApplication.shared.findTopViewController() == UIApplication.shared.keyWindow?.rootViewController);
    }
    
    func test_PresentedViewController() {
        
        self.addTeardownBlock {
            cleanup()
        }
        
        let root = UIViewController()
        let nav = UINavigationController(rootViewController: root)
        
        run { (complete) in
            UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: false, completion: {
                complete()
            })
        }
        
        XCTAssert(UIApplication.shared.findTopViewController() == root);
    }
    
    func test_UINavigationViewController() {
        
        self.addTeardownBlock {
            cleanup()
        }
        
        let root = UIViewController()
        let nav = UINavigationController(rootViewController: root)
        
        UIApplication.shared.keyWindow?.rootViewController = nav
        
        XCTAssert(UIApplication.shared.findTopViewController() == root);
    }
    
    func test_UITabBarController() {
        
        self.addTeardownBlock {
            cleanup()
        }
        
        let tab1 = UIViewController()
        let tab2 = UIViewController()
        let tab = UITabBarController()
        
        tab.viewControllers = [tab1, tab2]
        tab.selectedIndex = 1
        
        UIApplication.shared.keyWindow?.rootViewController = tab
        
        XCTAssert(UIApplication.shared.findTopViewController() == tab2);
    }
    
    func test_Child_UIViewController_Latest() {
        
        self.addTeardownBlock {
            cleanup()
        }
        
        let parent = UIViewController()
        
        let child1 = UIViewController()
        let child2 = UIViewController()
        let child3 = UIViewController()
        
        let add: (_ child: UIViewController, _ frame: CGRect) -> Void = { child, frame in
            child.willMove(toParent: parent)
            parent.addChild(child)
            child.view.frame = frame
            parent.view.addSubview(child.view)
            child.didMove(toParent: parent)
        }
        
        add(child1, parent.view.bounds)
        add(child2, parent.view.bounds)
        add(child3, parent.view.bounds)
        
        UIApplication.shared.keyWindow?.rootViewController = parent
        
        XCTAssert(UIApplication.shared.findTopViewController() == child3);
    }
    
    func test_Child_UIViewController_Hidden() {
        
        self.addTeardownBlock {
            cleanup()
        }
        
        let parent = UIViewController()
        
        let child1 = UIViewController()
        let child2 = UIViewController()
        let child3 = UIViewController()
        
        let add: (_ child: UIViewController, _ frame: CGRect) -> Void = { child, frame in
            child.willMove(toParent: parent)
            parent.addChild(child)
            child.view.frame = frame
            parent.view.addSubview(child.view)
            child.didMove(toParent: parent)
        }
        
        add(child1, parent.view.bounds)
        add(child2, parent.view.bounds)
        add(child3, parent.view.bounds)
        
        child3.view.isHidden = true
        
        UIApplication.shared.keyWindow?.rootViewController = parent
        
        XCTAssert(UIApplication.shared.findTopViewController() == child2);
    }
    
    func test_Child_UIViewController_Alpha() {
        
        self.addTeardownBlock {
            cleanup()
        }
        
        let parent = UIViewController()
        
        let child1 = UIViewController()
        let child2 = UIViewController()
        let child3 = UIViewController()
        
        let add: (_ child: UIViewController, _ frame: CGRect) -> Void = { child, frame in
            child.willMove(toParent: parent)
            parent.addChild(child)
            child.view.frame = frame
            parent.view.addSubview(child.view)
            child.didMove(toParent: parent)
        }
        
        add(child1, parent.view.bounds)
        add(child2, parent.view.bounds)
        add(child3, parent.view.bounds)
        
        child3.view.alpha = 0.049;
        
        UIApplication.shared.keyWindow?.rootViewController = parent
        
        XCTAssert(UIApplication.shared.findTopViewController() == child2);
    }
    
    func test_Child_UIViewController_Frame() {
        
        self.addTeardownBlock {
            cleanup()
        }
        
        let parent = UIViewController()
        
        let child1 = UIViewController()
        let child2 = UIViewController()
        let child3 = UIViewController()
        
        let add: (_ child: UIViewController, _ frame: CGRect) -> Void = { child, frame in
            child.willMove(toParent: parent)
            parent.addChild(child)
            child.view.frame = frame
            parent.view.addSubview(child.view)
            child.didMove(toParent: parent)
        }
        
        add(child1, parent.view.bounds)
        add(child2, parent.view.bounds)
        add(child3, parent.view.bounds)
        
        child3.view.alpha = 0.049;
        
        UIApplication.shared.keyWindow?.rootViewController = parent
        
        XCTAssert(UIApplication.shared.findTopViewController() == child2);
    }
    
}
