Pod::Spec.new do |s|
s.name             = "RXCLoadingStateManager"
s.version          = "1.0"
s.summary          = "easy way to handle the loading state"
s.homepage         = "https://github.com/ruixingchen/RXCLoadingStateManager"
s.license          = { type: 'MIT', file: 'LICENSE' }
s.author           = { "Ruixingchen" => "rxc@ruixingchen.com" }
s.source           = { git: "https://github.com/ruixingchen/RXCLoadingStateManager.git", tag: s.version.to_s }
s.ios.deployment_target = '11.0'
s.requires_arc = true
s.ios.source_files = 'Source/**/*.{h,m,swift}'
s.ios.frameworks = 'UIKit', 'Foundation'
s.swift_version = "4.2"

end