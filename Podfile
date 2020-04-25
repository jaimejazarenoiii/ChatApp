# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'ChatApp' do
  inhibit_all_warnings!
  inherit! :search_paths

  # Pods for ChatApp
  pod 'CodableFirebase'
  pod 'IQKeyboardManagerSwift'
  pod 'Firebase/Firestore'
  pod 'ReactiveCocoa'
  pod 'ReactiveSwift', '~> 6.1'
  pod 'Result'
  pod 'SnapKit', '~> 5.0.0'
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftLint'
  pod 'SwiftyUserDefaults', '~> 5.0'
end

# Makes sure each pod's IPHONEOS_DEPLOYMENT_TARGET is 13.0
post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
