Pod::Spec.new do |spec|
    spec.name         = "RXCLoadingStateManager"
    spec.version      = "1.0"

    spec.author       = { "ruixingchen" => "rxc@ruixingchen.com" }

    spec.summary      = "easy to manage loading state"
    spec.description  = "easy to manage loading state."
    spec.homepage     = "https://github.com/ruixingchen/RXCLoadingStateManager"
    spec.license      = "MIT"

    spec.source       = { :git => "https://github.com/ruixingchen/RXCLoadingStateManager.git", :tag => spec.version.to_s }
    #spec.source_files  = "Source/*.swift"

    spec.requires_arc = true
    spec.swift_versions = "5.1"
    spec.ios.deployment_target = '9.0'

    spec.default_subspecs = 'Core'

    spec.subspec 'Core' do |subspec|
        subspec.ios.source_files = 'Source/RXCLoadingStateManager.swift'
        subspec.ios.frameworks = 'UIKit'
    end

    spec.subspec 'SimplePlaceholderView' do |subspec|
        subspec.ios.source_files = 'Source/SimplePlaceholderView/*.swift'
        subspec.ios.frameworks = 'UIKit'
    end

end
  