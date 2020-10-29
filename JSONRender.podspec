#
# Be sure to run `pod lib lint JSONRender.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JSONRender'
  s.version          = '1.1.0'
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
  s.source_files = 'JSONRender/Classes/*'
  s.frameworks = 'UIKit'
  
end
