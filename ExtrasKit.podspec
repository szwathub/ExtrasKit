#
# Be sure to run `pod lib lint ExtrasKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ExtrasKit'
  s.version          = '1.0.0'
  s.summary          = 'A collection of useful Swift extension.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A collection of useful Swift extension.
                       DESC

  s.homepage         = 'https://github.com/szwathub/ExtrasKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'szwathub' => 'szwathub@gmail.com' }
  s.source           = { :git => 'https://github.com/szwathub/ExtrasKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version         = '5.0'
  s.source_files = ["ExtrasKit/**/*.swift", "ExtrasKit/ExtrasKit.h"]
end
