//
//  ObjCExample.m
//  TopViewControllerDemo
//
//  Created by Siarhei Ladzeika on 4/10/19.
//  Copyright © 2019 Siarhei Ladzeika. All rights reserved.
//

#import <Foundation/Foundation.h>
@import TopViewControllerDetection;

@implementation NSObject(ObjCExample)

+ (void)example {
    UIViewController* const viewController = [[UIApplication sharedApplication] findTopViewController];
}

@end
