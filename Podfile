platform :ios, '15.0'
inhibit_all_warnings!
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end

target 'Mars Rover' do

  use_frameworks!

# Firebase Authorization
pod 'Firebase/Auth'

# Firebase Firestore (Cloud Database)
pod 'Firebase/Firestore'

# This is used to support automatic type serialization in Swift
pod 'FirebaseFirestoreSwift', '8.9.0-beta'

# Firebase Storage (Cloud Storage)
pod 'Firebase/Storage'

# A tool to enforce Swift style and conventions
pod 'SwiftLint'

# Local database Realm
pod 'RealmSwift'

# Assets 
pod 'SwiftGen'

# Dependency injection
pod 'Swinject'

# Constraints
pod 'SnapKit'

end
