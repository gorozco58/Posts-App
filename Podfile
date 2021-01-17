use_frameworks!
inhibit_all_warnings!
platform :ios, '13.0'

def networkPods
  pod 'Alamofire', '~> 5.1'
  pod 'AlamofireImage', '~> 4.1'
end

def commonPods
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'CouchbaseLite-Swift', '~> 2.8'
end

target 'Koombea Test' do
  commonPods
  networkPods
end
