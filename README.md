
<p align="center">
<img src="https://raw.github.com/LeoMobileDeveloper/LHPerformanceStatusBar/master/Screenshot/image.png" alt="LHPerformanceStatusBar" title="LHPerformanceStatusBar"/>
</p>

[![Version](https://img.shields.io/cocoapods/v/LHPerformanceStatusBar.svg?style=flat)](http://cocoapods.org/pods/LHPerformanceStatusBar)  [![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
 [![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

# LHPerformanceStatusBar

Replace statusbar with a new bar to show realtime performance

- FPS
- CPU
- Memory


## Install

Cocoapod

```
pod 'LHPerformanceStatusBar',:git => 'https://github.com/lileitao/LHPerformanceStatusBar.git', :configurations => ['Debug']
```

## Usage
In `viewDidAppear` or somewhere where the keyWindow is loaded

```
//在项目中添加一个UIViewController的分类，在分类中实现以下方法：
- (void)performanceNotifyWithDic:(NSDictionary *)dic;
// 性能指标项：fpsStr：fps， memoryStr:内存占比； cpuStr:cpu占比；
// dic中存储的是每个页面的性能指标平均值。进入页面开始统计，将要离开页面的时候会计算性能的平均值，回调该方法，以字典形式传输；

```
## Author

Leo, leomobiledeveloper

## License

LHPerformanceStatusBar is available under the MIT license. See the LICENSE file for more info.
