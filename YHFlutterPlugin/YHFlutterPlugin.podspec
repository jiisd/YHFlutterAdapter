Pod::Spec.new do |s|
  s.name         = 'YHFlutterPlugin'
  s.version      = '0.0.1'
  s.summary      = 'YHFlutterPlugin'
  s.description  = <<-DESC
                    三行代码组件化集成 Flutter！该 Pod 组件用于对 YHFlutterAdapter 提供相关的桥接方法与插件的功能扩增。
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
