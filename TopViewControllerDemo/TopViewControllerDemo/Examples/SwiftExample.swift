//
//  SwiftExample.swift
//  TopViewControllerDemo
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//

import UIKit
import TopViewControllerDetection

extension NSObject {

    @MainActor
    func swiftExample() {
        let _: UIViewController? = UIApplication.shared.findTopViewController()
    }
    
}
