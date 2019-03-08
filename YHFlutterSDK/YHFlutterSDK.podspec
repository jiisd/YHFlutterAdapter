Pod::Spec.new do |s|
  s.name         = 'YHFlutterSDK'
  s.version      = '0.0.3'
  s.summary      = 'YHFlutterSDK'
  s.description  = <<-DESC
                    三行代码组件化集成 Flutter！该 Pod 组件用于存放 Flutter 编译后的产物，各个业务线可针对于自己的 Flutter 项目需求来生成对应的独立产物，与 YHFlutterAdapter 和 YHFlutterPlugin 组装使用。
                   DESC

  s.homepage     = 'https://github.com/jiisd/YHFlutterAdapter'
  s.license      = 'MIT'
  s.author       = { 'yaheng.zheng' => 'yahengzheng@163.com' }
  s.platform     = :ios, '9.0'

  s.source       = { :git => 'git@github.com:jiisd/YHFlutterAdapter.git',:tag => s.version }
  s.requires_arc = true

  s.vendored_frameworks = 'YHFlutterSDK/**/*.{framework}'
end
