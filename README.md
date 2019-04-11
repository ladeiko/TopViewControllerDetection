# TopViewControllerDetection

[![Build Status](https://travis-ci.org/ladeiko/TopViewControllerDetection.svg?branch=master)](https://travis-ci.org/ladeiko/TopViewControllerDetection)

Contains helper code (extension to UIApplication/UIViewController) to detect top visible view controller.

## Installation

### Cocoapods
> This is the recommended way of installing this package.

* Add the following line to your Podfile

``` ruby
pod 'TopViewControllerDetection'
```
* Run the following command to fetch and build your dependencies

``` bash
pod install
```

### Manually
If you prefer to install this package manually, just follow these steps:

* Make sure your project is a git repository. If it isn't, just run this command from your project root folder:

``` bash
git init
```

* Add TopViewControllerDetection as a git submodule by running the following command.

``` bash
git submodules add https://github.com/ladeiko/TopViewControllerDetection.git
```
* Add files ('.swift') from *'submodules/TopViewControllerDetection/Source'* folder to your project.

## Usage

### Swift

See [SwiftExample.swift](TopViewControllerDemo/TopViewControllerDemo/Examples/SwiftExample.swift)

``` swift
import TopViewControllerDetection

let absoluteTopViewController = UIApplication.shared.topViewController()

func viewDidLoad() {
	super.viewDidLoad()
	let topViewControllerRelativeToSelf = self.topViewController()
}


// Async version

self.topViewController { viewController in
    if let viewController =  viewController {
        // TODO
    }
}

```

### Objective-C

See [ObjCExample.m](TopViewControllerDemo/TopViewControllerDemo/Examples/ObjCExample.m)

```objective-c
@import TopViewControllerDetection;

UIViewController* const absoluteTopViewController = [[UIApplication sharedApplication] topViewController];

- (void)viewDidLoad {
	[super  viewDidLoad];
	UIViewController* const topViewControllerRelativeToSelf = [self topViewController];
}

```

## Changelog

See [CHANGELOG](CHANGELOG.md)

## LICENSE
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
