#
# Be sure to run `pod lib lint ExtrasKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ExtrasKit'
  s.version          = '2.0.1'
  s.summary          = 'A collection of useful Swift extension.'
  s.description      = <<-DESC
A collection of useful Swift extension for standard types and classes.
                       DESC

  s.homepage         = 'https://github.com/szwathub/ExtrasKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'szwathub' => 'szwathub@gmail.com' }
  s.source           = { :git => 'https://github.com/szwathub/ExtrasKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version         = '5.0'
  s.source_files = 'ExtrasKit/**/*.swift'
end
