Pod::Spec.new do |s|
  s.name         = 'YHFlutterAdapter'
  s.version      = '0.0.1'
  s.summary      = 'YHFlutterAdapter'
  s.description  = <<-DESC
                    三行代码组件化集成 Flutter！可用于已有 iOS 项目，对原工程无侵入，无需更改原项目配置，集成后可直接以组件形式开发 Flutter 业务。
                    该模块内的功能应逐渐下沉为通用功能，需要供多个业务线直接复用。
                   DESC

  s.homepage     = 'https://github.com/jiisd/YHFlutterAdapter'
  s.license      = 'MIT'
  s.author       = { 'yaheng.zheng' => 'yahengzheng@163.com' }
  s.platform     = :ios, '9.0'

  s.source       = { :git => 'git@github.com:jiisd/YHFlutterAdapter.git',:tag => s.version }
  s.requires_arc = true

  s.source_files = 'YHFlutterAdapter/**/*.{h,m}'
  s.public_header_files = 'YHFlutterAdapter/Public/*.h'

  s.dependency 'YHFlutterSDK'
end
