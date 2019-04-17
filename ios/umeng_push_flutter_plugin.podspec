#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'umeng_push_flutter_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for umeng push service'
  s.description      = <<-DESC
A Flutter plugin for umeng push service
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'


    s.name = 'UMCCommon'
    s.name = 'UMCPush'
    s.name = 'UMCSecurityPlugins'

  s.ios.deployment_target = '9.0'
end