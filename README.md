# SPPageMenu
[![Build Status](http://img.shields.io/travis/SPStore/SPPageMenu.svg?style=flat)](https://travis-ci.org/SPStore/SPPageMenu)
[![Pod Version](http://img.shields.io/cocoapods/v/SPPageMenu.svg?style=flat)](http://cocoadocs.org/docsets/SPPageMenu/)
[![Pod Platform](http://img.shields.io/cocoapods/p/SPPageMenu.svg?style=flat)](http://cocoadocs.org/docsets/SPPageMenu/)
![Language](https://img.shields.io/badge/language-Object--C-ff69b4.svg)
[![Pod License](http://img.shields.io/cocoapods/l/SPPageMenu.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/SPStore/SPPageMenu)
![codecov](https://img.shields.io/badge/codecov-88%25-orange.svg)

# 目录
* [如何安装](#如何安装)
* [部分功能演示图](#部分功能演示图)
* [重难点讲解](#疑难讲解) 

## 如何安装
#### 版本3.4.0
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 3.4.0'
end

说明：3.4.0版本在3.0版本的基础上主要改动如下：
1、增加trackerFollowingMode属性，跟踪器跟踪模式
2、增加selectedItemTitleFont和unSelectedItemTitleFont属性，设置选中item的标题字体和非选中item的标题字体
3、增加设置和获取背景图片的方法
4、修复跟踪器缩放文字显示不全问
5、优化代码
```

#### 版本3.0
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 3.0'
end

说明：3.0版本在2.5.5版本的基础上主要改动如下：
1、新增numberOfItems属性，意思是items的个数
2、新增bounces属性，滑动scrollView时的边界反弹效果
3、新增alwaysBounceHorizontal属性，水平方向上，当内容没有充满scrollView时，滑动scrollView是否有反弹效果
4、新增设置或获取指定按钮的四周内边距的方法
5、分割线适配屏幕分辨率，并修改了默认颜色
6、内部scrollView的scrollsToTop属性置为NO,不妨碍外界scrollView的置顶功能
7、右侧功能按钮的单边阴影效果采用shadowPath
8、细化内部的自定义按钮，比如可以设置文字与图片之间的间距
9、修复设置指定item的文字较长时的显示不全的问题
10、修复插入和删除操作引发的bug
11、修复长按按钮然后滑动scrollView无法滑动问题
```

#### 版本2.5.5
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 2.5.5'
end

说明：2.5.5版本在2.5.3版本的基础上主要改动如下：
1、增加可以设置跟踪器宽度的属性，增加可以设置跟踪器高度和圆角半径的方法
2、修复了当未选中按钮颜色的alpha值小于1时，颜色渐变不准确问题
3、废弃了文字缩放(SPPageMenuTrackerStyleTextZoom)的枚举，该枚举由属性selectedItemZoomScale
   代替，增加了SPPageMenuTrackerStyleNothing枚举
4、可以设置分割线高度
```

##### 版本2.5.3
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 2.5.3'
end
```
## 部分功能演示图
（友情提示：如果您的网络较慢，gif图可能会延迟加载，您可以先把宝贵的时间浏览其它信息）

![image](https://github.com/SPStore/SPPageMenu/blob/master/3006981-889f087b55f3e57f.gif)
## 重难点讲解
```

```

### 使用示例大家可以把demo下载到本地，里面有非常多的示例以及详细的注释
[回到顶部](##目录)

