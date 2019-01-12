Pod::Spec.new do |s|
  s.name         = 'YHFlutterAdapter'
  s.version      = '0.0.2'
  s.summary      = 'YHFlutterAdapter'
  s.description  = <<-DESC
                    三行代码组件化集成 Flutter！可用于已有 iOS 项目，对原工程无侵入，无需更改原项目配置，集成后可直接以组件形式开发 Flutter 业务。
                    该 Pod 组件负责 Flutter 功能与原生端代码的隔离解耦，并提供一定的插件注册功能，该模块对 YHFlutterSDK 以及 YHFlutterPlugin 无依赖关系，并且其中的功能应逐渐下沉为通用功能，可供多个业务线直接复用。
                   DESC

  s.homepage     = 'https://github.com/jiisd/YHFlutterAdapter'
  s.license      = 'MIT'
  s.author       = { 'yaheng.zheng' => 'yahengzheng@163.com' }
  s.platform     = :ios, '9.0'

  s.source       = { :git => 'git@github.com:jiisd/YHFlutterAdapter.git',:tag => s.version }
  s.requires_arc = true

  s.source_files = 'YHFlutterAdapter/**/*.{h,m}'
  s.public_header_files = 'YHFlutterAdapter/Public/*.h'
end
