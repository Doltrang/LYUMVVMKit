# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LYUMVVMKit' do
  use_frameworks!
  pod 'Moya/RxSwift', '~> 11.0.1'
  pod 'RxCocoa', '~> 4.1.2'
  pod 'RxDataSources', '~> 3.0.2'
  pod 'NSObject+Rx', '~> 4.3.0'
  
  
  pod 'SnapKit', '~> 4.0.0'
  pod 'Then', '~> 2.3.0'
  pod 'Reusable', '~> 4.0.2'
  pod 'ESTabBarController-swift', '~> 2.6.1'
  pod 'IQKeyboardManagerSwift', '~> 5.0.8'
  pod 'Toast-Swift', '~> 3.0.1'
  
  
  
  pod 'Kingfisher', '~> 4.6.3'
  pod 'MJRefresh', '~> 3.1.15.3'
  pod 'SVProgressHUD', '~> 2.2.5'
  pod 'HandyJSON', '~> 4.1.1'
  #  pod 'MonkeyKing'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
            target.build_configurations.each do |config|
                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                end
            end
        end
    end
end


end
