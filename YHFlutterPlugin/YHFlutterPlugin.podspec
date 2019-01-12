Pod::Spec.new do |s|
  s.name         = 'YHFlutterPlugin'
  s.version      = '0.0.2'
  s.summary      = 'YHFlutterPlugin'
  s.description  = <<-DESC
                    三行代码组件化集成 Flutter！该 Pod 组件主要配合 YHFlutterAdapter 实现部分桥接方法与插件的功能。
                    可创建多个，一些用于提供通用基础桥接功能，另一些专门用于具体特定业务实现逻辑，上层项目选择性的引入即可。
                   DESC

  s.homepage     = 'https://github.com/jiisd/YHFlutterAdapter'
  s.license      = 'MIT'
  s.author       = { 'yaheng.zheng' => 'yahengzheng@163.com' }
  s.platform     = :ios, '9.0'

  s.source       = { :git => 'git@github.com:jiisd/YHFlutterAdapter.git',:tag => s.version }
  s.requires_arc = true

  s.source_files = 'YHFlutterPlugin/**/*.{h,m}'

  s.dependency 'YHFlutterAdapter'
end
