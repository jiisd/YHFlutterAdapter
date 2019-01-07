# YHFlutterAdapter ![](http://git.oschina.net/NSLogHeng/imageFiles/raw/master/codeAvatar.png)

[![GitHub stars](https://img.shields.io/github/stars/jiisd/YHFlutterAdapter.svg)](https://github.com/jiisd/YHFlutterAdapter/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/jiisd/YHFlutterAdapter.svg)](https://github.com/jiisd/YHFlutterAdapter/network)
[![GitHub license](https://img.shields.io/github/license/jiisd/YHFlutterAdapter.svg)](https://github.com/jiisd/YHFlutterAdapter/blob/master/LICENSE)

## 三行代码组件化集成 Flutter！可用于已有 iOS 项目，对原工程无侵入，无需更改原项目配置，集成后可直接以组件形式开发 Flutter 业务。
 

### 结构图

![](https://raw.githubusercontent.com/jiisd/YHFlutterAdapter/master/diagram.png)

 
主要目录介绍：

```
.
|__YHFlutterAdapter(负责 Flutter 功能与原生端代码的隔离解耦，并提供一定的插件注册功能，该模块内的功能应逐渐下沉为通用功能，可供多个业务线直接复用。)
|__YHFlutterSDK(存放 Flutter 项目编译后生成的产物，各个业务线可针对于自己的 Flutter 项目需求来生成对应的独立产物，与 YHFlutterAdapter 和 YHFlutterPlugin 组装使用。)
|__YHFlutterPlugin(主要用于对 YHFlutterAdapter 提供相关的桥接方法与插件的功能扩增。)
|__Demo(使用样例。)
```
-----

### 集成方式
```
Podfile 内添加

pod 'YHFlutterAdapter'
pod 'YHFlutterSDK'
pod 'YHFlutterPlugin'

```
具体集成细节，podspec指向等可参照项目内 Demo 。

-----

### 使用方式
1、添加引用

```
#import <YHFlutterAdapter/YHFlutterModule.h>
```

2、加载 Flutter 界面

>2.1、在项目内直接显示调用

```
UIViewController *flutterViewController = [[YHFlutterModule service] flutterViewControllerForKey:@"XXXX" properties:nil];
[self presentViewController:flutterViewController animated:YES completion:nil];
```
>2.2、【推荐】将 ``YHFlutterModule`` 注册进项目内已有的组件化服务内并调用 ``YHFlutterServiceProtocol`` 的相关方法使用

3、如何扩增与 Flutter 交互的桥接方法或者添加新的 Plugin

>3.1、可参照 Demo 内的 ``YHFlutterFeatureBridgeTest``，具体的业务使用方在上层项目内可自行注册监听并处理自己需要的消息；

>3.2、也可参照 ``YHFlutterPlugin`` 编写新的 pod 仓库组件独立实现；

4、Plugin & Channel 注册方式

>4.1、使用 ``[YHFlutterModule service]`` 注册
>``[[YHFlutterModule service] registMethodChannelHandler:self.class];``

>4.2、使用 ``YHFlutterRegistrant`` 注册
>``[YHFlutterRegistrant registMethodChannelHandler:self.class];``

>4.3、【推荐】将 ``YHFlutterModule`` 注册进项目内已有的组件化服务内并调用 ``YHFlutterServiceProtocol`` 的相关方法进行注册

5、YHFlutterSDK 内产物更新方式
>5.1、手动更新：
>>5.1.1、Flutter 工程目录下 ``./.ios/`` 内对应工程的 BundleId 以及证书更换为当前电脑中任何一个可用的，保证通过编译

>>5.1.2、Flutter 工程目录下使用 ``flutter build ios`` or ``flutter build ios --debug`` 命令生成对应的 ``release`` or ``debug`` 版本的产物

>>5.1.3、cd 到 ``./.ios/Flutter/`` 目录下将对应的三个产物更换到 YHFlutterSDK 内

>5.2、【建议】自动更新：编写对应的脚本实现 编译-转移产物-更新到远端 Pod 的操作，同时将 ``YHFlutterPlugin`` 中需要添加的依赖类自动更新并注册进 ``YHFlutterAdapter ``

-----
### 示例图

![](https://raw.githubusercontent.com/jiisd/YHFlutterAdapter/master/demoGif.gif)

-----
### LICENSE

All source code is licensed under the MIT License.




​    
