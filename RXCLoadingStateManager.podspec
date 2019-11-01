Pod::Spec.new do |s|
s.name             = "RXCLoadingStateManager"
s.version          = "1.0"
s.summary          = "easy way to handle the loading state"
s.homepage         = "https://github.com/ruixingchen/RXCLoadingStateManager"
s.license          = { type: 'MIT', file: 'LICENSE' }
s.author           = { "Ruixingchen" => "rxc@ruixingchen.com" }
s.source           = { git: "https://github.com/ruixingchen/RXCLoadingStateManager.git", tag: s.version.to_s }
s.ios.deployment_target = '8.0'
s.requires_arc = true
s.ios.source_files = 'Source/*.swift'
s.ios.frameworks = 'UIKit'
s.swift_version = "5.1"

default_subspec = 'Core'

subspec 'Core' do |subspec|
    subspec.ios.source_files = 'Source/*.swift'
    subspec.ios.frameworks = 'UIKit'
    subspec.ios.deployment_target = '8.0'
    subspec.requires_arc = true
end

subspec 'SimplePlaceholderView' do |subspec|
    subspec.ios.source_files = 'Source/SimplePlaceholderView/*.swift'
    subspec.ios.deployment_target = '9.0'
    subspec.ios.frameworks = 'UIKit'
end

end