#
# Be sure to run `pod lib lint JSONRenderSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JSONRenderSwift'
  s.version          = '1.1.1'
  s.summary          = 'A easy way to render and highlight JSON to rich text'
  s.description      = <<-DESC
A easy way to render and highlight JSON to rich text.
                       DESC

  s.homepage         = 'https://github.com/ad0ma/JSONRender'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ad0ma' => 'adomacn@gmail.com' }
  s.source           = { :git => 'https://github.com/ad0ma/JSONRender.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '5'
  s.source_files = 'JSONRenderSwift/Classes/*'
  s.frameworks = 'UIKit'

end
