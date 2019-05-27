Pod::Spec.new do |s|

  s.name         = "TopViewControllerDetection"
  s.version      = "2.0.0"
  s.summary      = "TopViewControllerDetection - helper code to detect current top visible UIViewController"

  s.homepage         = "https://github.com/ladeiko/TopViewControllerDetection"
  s.license          = 'MIT'
  s.authors           = { "Siarhei Ladzeika" => "sergey.ladeiko@gmail.com" }
  s.source           = { :git => "https://github.com/ladeiko/TopViewControllerDetection.git", :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  s.swift_version = '4.2'
  s.source_files =  "Source/*.swift"
  
end
