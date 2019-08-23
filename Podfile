# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

def rx_swift
    pod 'RxSwift', '~> 4.0'
end


target 'Model' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Model
  rx_swift

  target 'ModelTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'RXNetworkPlatform' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RXNetworkPlatform
  rx_swift
  
  pod 'Alamofire'
  pod 'RxAlamofire'
  
  target 'RXNetworkPlatformTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'WechatMomentsTW' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WechatMomentsTW
  rx_swift

  target 'WechatMomentsTWTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
