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
* [重难点讲解](#重难点讲解) 
* [使用者提问](#使用者提问)

## 如何安装
#### 版本3.4.6
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 3.4.6'
end

说明：3.4.6版本在3.4.5版本的基础上新增了-setContent:forItemIndex:方法，修复了多次对bridgeScrollView赋值没有移除上一个观察者问题
```
#### 版本3.4.5
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 3.4.5'
end

说明：3.4.5版本在3.4.4版本的基础上修复了先设置unSelectedItemTitleFont，再设置items文字显示不全问题
```

#### 版本3.4.4
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 3.4.4'
end

说明：3.4.4版本在3.4.2版本的基础上改动如下:
1、重构了内部自定义按钮
2、解决了标题颜色的alpha值小于1时颜色渐变不准确问题
3、新增SPPageMenuButtonItem模型，用于同时设置文字和图片
```

#### 版本3.4.2
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 3.4.2'
end

说明：3.4.2版本在3.4.1版本的基础上,trackStyle属性支持storyBoard/xib,方便在storyBoard/xib中创建时可以直接设置
```

#### 版本3.4.1
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 3.4.1'
end

3.4.1版本在3.4.0版本的基础上修复了多次调用setItems:selectedItemIndex:方法引发的问题
```

#### 版本3.4.0
```
target 'MyApp' do
  pod 'SPPageMenu', '~> 3.4.0'
end

说明：3.4.0版本在3.0版本的基础上主要改动如下：
1、增加trackerFollowingMode属性，跟踪器跟踪模式
2、增加selectedItemTitleFont和unSelectedItemTitleFont属性，设置选中item的标题字体和非选中item的标题字体
3、增加设置和获取背景图片的方法
4、修复跟踪器缩放文字显示不全问题
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
// 该属性是选中的按钮下标，大家可以通过这个属性判断选择了第几个按钮，如果改变其值，可以用于切换选中的按钮

@property (nonatomic) NSInteger selectedItemIndex; 
```
```
// 这个scrollView是外界传进来的scrollView，通常的案例都是在pageMenu的下方有若干个子控制器在切换，子控制器的切换由滑动
scrollView实现，使用者只需要把该scrollView传给bridgeScrollView，SPPageMenu框架内部会监听该scrollView的横向滚动，实
现了让跟踪器时刻跟随该scrollView滚动的效果。暂时不支持监听垂直方向的滚动，如果你的scrollVeiw要垂直滚动实现切换按钮，你
不妨可以尝试自己在-scrollViewDidScroll：代理方法中设置selectedItemIndex的值

@property (nonatomic, strong) UIScrollView *bridgeScrollView;
```
```
// 排列方式：支持3种排列方式；1、可滑动，按钮宽度根据内容自适应；2、不可滑动，按钮等宽；3、不可滑动，按钮宽度根据内容自
适应。3种排列方式都有非常高的使用频率。第1种排列方式：SPPageMene的容量会根据按钮个数而定；第2种和第3种排列方式:SPPageMenu
的容量固定为SPPageMenu的宽度

@property (nonatomic, assign) SPPageMenuPermutationWay permutationWay; 
```
```
// 跟踪器跟踪模式；这个属性从3.4版本开始闪亮登场。该属性是个枚举，共3个：1、SPPageMenuTrackerFollowingModeAlways，这个
枚举值的意思是让跟踪器时刻跟随外界scrollView(即bridgeScrollView)横向移动； 2、SPPageMenuTrackerFollowingModeEnd，这个
枚举的意思是当外界scrollView滑动结束时，跟踪器才开始移动；相当于3.4版本之前的closeTrackerFollowingMode属性 3、
SPPageMenuTrackerFollowingModeHalf，这个枚举的意思是当外界scrollView拖动距离超过屏幕一半时，跟踪器开始移动。

@property (nonatomic, assign) SPPageMenuTrackerFollowingMode trackerFollowingMode;
```
```
// 内容的四周内边距(内容不包括分割线)，默认UIEdgeInsetsZero;这个属性是个惊喜，往往能做到一些你意想不到的事情。假如你的
SPPageMenu控件高度固定不变，想要设置跟踪器与按钮之间的垂直间距变小，就可以设置该属性的top和bottom值，让SPPageMenu的
内容在垂直方向上内缩

@property (nonatomic, assign) UIEdgeInsets contentInset; 
```
```
// 该方法的效果和属性bridgeScrollView功能一致，如果外界想通过该方法实现跟踪器时刻跟随scrollView移动，可以在代理方法
-scrollViewDidScroll:中调用该方法，如果方法和属性同时实现，属性优先级更高

- (void)moveTrackerFollowScrollView:(UIScrollView *)scrollView;
```
```
// 代理方法：若以下2个代理方法同时实现了，只会走第2个代理方法（第2个代理方法包含了第1个代理方法的功能）
// 代理方法何时触发？代理方法有2种方式会触发，第一种是点击了SPPageMenu的按钮，这种方式无论点击的按钮是否同一个都会触发；
第二种是由滑动外界scrollView而触发，当跟踪模式为SPPageMenuTrackerFollowingModeAlways和SPPageMenuTrackerFollowingModeEnd
时，滑动scrollView结束的时候触发地代理方法，当跟踪器的跟踪模式为SPPageMenuTrackerFollowingModeHalf时，滑动scrollView
超过一半时就会触发代理方法

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index;
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
```
### 想了解更多使用细节，大家可以把demo下载到本地，里面有非常多的示例以及详细的注释

# 使用者提问
* **问**：当我设置排列方式为按钮等宽(即SPPageMenuPermutationWayNotScrollEqualWidths)，为什么按钮文字显示不全？<br>
  **答**：这是因为你的按钮个数较多或者文字较长，你可以通过设置itemPadding属性来调整按钮之间的间距，间距调小，每个按钮的宽度就会增大，
          如果itemPadding设置为0仍然显示不全，那就请选择其它排列方式。
          
* **问**：如何不通过点击按钮或者滑动外界scrollView来实现选中按钮的切换 ?<br>
  **答**：你可以改变selectedItemIndex的值切换选中按钮
  
* **问**：如何在不改变pageMenu高度的情况下，让跟踪器和按钮之间的垂直间距变小 ？ <br>
  **答**：你可以通过设置contentInset的top和bottom值，让pageMenu的内容在垂直方向上往中间挤压
  
* **问**：如何给按钮设置角标 ？ <br>
  **答**：本框架并未单独提供设置角标的方法，因为设置角标是一个比较大的工程，如果提供角标，又得给角标提供各种属性设置，这将会把本框架搞的非常臃肿，这也
         不是本框架的重点内容，但是也不是不可以设置，你可以通过KVC获取按钮的数组buttons，然后通过该数组获取指定按钮，拿到该按钮就可以设置角标，具体
         事例demo中有示范

[回到顶部](#目录)

