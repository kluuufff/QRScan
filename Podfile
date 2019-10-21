project 'UITest.xcodeproj'

# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'
use_frameworks!

target 'UITest' do
  pod 'SwiftyJSON'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
 end
end