//
//  SPPageMenu.m
//  SPPageMenu
//
//  Created by leshengping on 16/9/6.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import "SPPageMenu.h"
#define tagIndex 2016

@interface SPPageMenu()

@property (nonatomic, strong) NSArray *menuArray;  // 该数组中装的是字符串，由外界传进来
@property (nonatomic, weak) UIScrollView *scrollView;  // 该scrollView用来承载菜单button
@property (nonatomic, weak) UIView *breakline;         // 分割线
@property (nonatomic, strong) NSMutableArray *menuButtonArray;  // 此数组用来装button

@end
static CGFloat menuButtonX = 0;
@implementation SPPageMenu


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 分割线，添加分割线必须在添加scrollView前面，并且将scrollView的背景色设置成无色（全透明）。如果在添加scrollView之后再添加分割线，那么menuButton的底部下划线将会有一部分高度（此高度就是分割线的高度）被分割线挡住
        UIView *breakline = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1.0f, frame.size.width, 1.0f)];
        breakline.backgroundColor = [UIColor lightGrayColor];
        self.breakline = breakline;
        [self addSubview:breakline];
        
        // 创建承载菜单button的scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView = scrollView;
        // 设置全透明颜色(必须）
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
    }
    return self;
}

// 此方法是留给外界的接口，以创建菜单栏
+ (SPPageMenu *)pageMenuWithFrame:(CGRect)frame array:(NSArray *)array {
    SPPageMenu *menu = [[SPPageMenu alloc] initWithFrame:frame];
    menu.menuArray = array;
    return menu;
}

- (void)setMenuArray:(NSMutableArray *)menuArray {
    _menuArray = menuArray;
    [self configureMenuButtonToScrollView];
}

// 添加以及配置menubutton的相关属性
- (void)configureMenuButtonToScrollView {
    // 移除已经有按钮,以防某个地方再次调用了此方法时,重复创建button
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    if (!self.buttonFont) {
        // 默认为15号字体
        _buttonFont = [UIFont systemFontOfSize:15];
    }
    // 设置button之间的间距
    if (!self.padding) {
        _padding = 30.f;
    }
    // 第一个menuButton的x值
    menuButtonX = 0.5 * _padding;
    // 装载button的数组初始化
    self.menuButtonArray = [NSMutableArray array];
    // 创建button
    for (int i = 0; i < _menuArray.count; i++) {
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 以下是menuButton的相关设置
        menuButton.tag = tagIndex + i;
        [menuButton addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuButton setTitle:self.menuArray[i] forState:UIControlStateNormal];
        [menuButton setBackgroundColor:[UIColor clearColor]];
        menuButton.titleLabel.font = _buttonFont;
        menuButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setUpButtonColor:menuButton];
        
        if (self.scrollView.subviews.count > 0) {
            // 非第一个,其x值等于最后一个button的终结x值+间距
            menuButtonX = CGRectGetMaxX([self.scrollView.subviews lastObject].frame) + _padding;
        }
        [self sizeWithString:self.menuArray[i] menuButton:menuButton menuButtonX:menuButtonX];
        
        if (i == 0) {
            // 默认第一个选中
            self.selectedButton = menuButton;
            
            // 跟踪button的下划线
            UIView *tracker = [[UIView alloc] init];
            CGFloat x = 0.0f;
            CGFloat w = CGRectGetMaxX(_selectedButton.frame) + 0.5 * _padding;
            if (!self.trackerHeight) {
                _trackerHeight = 2.0f;
            }
            CGFloat h = _trackerHeight;
            CGFloat y = CGRectGetMaxY(_selectedButton.frame) - h;
            tracker.frame = CGRectMake(x, y, w, h);
            self.tracker = tracker;
            tracker.backgroundColor = [UIColor redColor];
            [self.scrollView addSubview:tracker];
        }
        // 添加menuButton必须在添加tracker之后，必须保证scrollView里面装的最后一个控件是menuButton,因为menuButtonX依赖于最后一个menuButton
        [self.scrollView addSubview:menuButton];
        
        // 将button全部装到一个数组里面，以方便以后需拿到这些button时,可以从数组里面取出来
        [self.menuButtonArray addObject:menuButton];
    }
    [self setScrollViewContentSize];
}

// 设置scrollView的总容量
- (void)setScrollViewContentSize {
    if (self.scrollView.subviews.count > 0) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([self.scrollView.subviews lastObject].frame) + 0.5 * _padding, 0);
    }
}

// 计算button的frame
- (void)sizeWithString:(NSString *)string menuButton:(UIButton *)menuButton menuButtonX:(CGFloat)menuButtonX {
    // button需要根据文字返回动态宽度
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_buttonFont} context:nil].size;
    menuButton.frame = CGRectMake(menuButtonX, 0, size.width, self.scrollView.frame.size.height);
}

// 重写set方法，设置button字体
- (void)setButtonFont:(UIFont *)buttonFont {
    _buttonFont = buttonFont;
    // 从数组中取出菜单上的button，设置每个button的字体。如果不这样做，也可以在此直接调用setUpMenuButton方法，但是那样似乎多做了些无用的操作
    menuButtonX = 0.5 * _padding;
    for (int i = 0 ;i < self.menuButtonArray.count ;i++) {
        // 取出当前button
        UIButton *menuButton = self.menuButtonArray[i];
        // 重新设置button的字体
        menuButton.titleLabel.font = buttonFont;
        if (i > 0) {
            // 取出上一个button
            UIButton *lastButton = self.menuButtonArray[i - 1];
            // 当前button的x值等于上一个button的终结x值+间距
            menuButtonX = CGRectGetMaxX(lastButton.frame) + _padding;
        }
        [self sizeWithString:menuButton.titleLabel.text menuButton:menuButton  menuButtonX:menuButtonX];
    }
}

// 设置所有button的初始颜色
- (void)setUpButtonColor:(UIButton *)menuButton {
    if (self.unSelectedColor) {
        [menuButton setTitleColor:self.unSelectedColor forState:UIControlStateNormal];
    } else {
        [menuButton setTitleColor:[UIColor colorWithRed:104/255.0 green:104/255.0 blue:124/255.0 alpha:1.f] forState:UIControlStateNormal];
    }
}

// 重写set方法，设置选中的button
- (void)setSelectedButton:(UIButton *)selectedButton {
    // 这个if语句就是判断选中的button是否和之前选中的button是否一致，比如用户两次点击同一个button，那么第二次点击调用此方法时就直接retutn,没必要再去设置什么，设置了也是重复而已
    if (selectedButton == _selectedButton) {
        return;
    }
    // 计算scrollView的偏移量
    CGFloat originX = [self calculationScrollViewOffSet:selectedButton];
    [self.scrollView setContentOffset:CGPointMake(originX, 0) animated:YES];
    
    // 改变按钮颜色
    // _selectedButton指的是上一次选中的utton
    // 这就是为什么_selectedButton = selectedButton写在最后一行的原因，如果写在第一行，则_selectedButton与selectedButton就永远是同一个了
    if (self.unSelectedColor) {
        [_selectedButton setTitleColor:self.unSelectedColor forState:UIControlStateNormal];
    } else {
        [_selectedButton setTitleColor:[UIColor colorWithRed:104/255.0 green:104/255.0 blue:124/255.0 alpha:1.f] forState:UIControlStateNormal];
    }
    if (self.selectedColor) {
        [selectedButton setTitleColor:_selectedColor forState:UIControlStateNormal];
    } else {
        // 默认颜色
        [selectedButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
//    CGRect newFrame = self.tracker.frame;
//    // x
//    newFrame.origin.x = selectedButton.frame.origin.x - 0.5 * _padding;
//    // 宽
//    newFrame.size.width = selectedButton.frame.size.width + _padding;
//    //  执行动画
//    [UIView animateWithDuration:0.1 animations:^{
//        self.tracker.frame = newFrame;
//    }];
    
    // 开启动画，默认不开启
    if (_openAnimation) {
        [self openAnimationWithButton1:_selectedButton button2:selectedButton];
    }
    
    // 赋值必须写在最后，因为_selectedButton记录的是当前选中的button,当下一次在进入此方法时,要保证_selectedButton记录的是上一次选中的button
    _selectedButton = selectedButton;
    
}

// 计算scrollView的偏移量
- (CGFloat)calculationScrollViewOffSet:(UIButton *)selectedButton {
    // CGRectGetMidX(self.scrollView.frame)指的是屏幕水平中心位置，它的值是固定不变的
    CGFloat originX = selectedButton.center.x - CGRectGetMidX(self.scrollView.frame);
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    if (originX < 0) { // 说明选中的那个button的中心位置小于屏幕中心位置
        originX = 0;
    } else if (originX > maxOffsetX){ // 当选中的那个button中心位置大于屏幕中心位置时，那么直接将scrollView水平偏移originX，这时候的originX还是等于selectedButton.center.x - CGRectGetMidX(self.scrollView.frame),当此差值一直增加，一直增加到大于maxOffsetX时，则scrollView保持原先偏移量，不再继续偏移
        originX = maxOffsetX;
    }
    return originX;
}

// 重写set方法,是否开启动画
- (void)setOpenAnimation:(BOOL)openAnimation {
    _openAnimation = openAnimation;
    if (openAnimation) {
        // 取出第一个button
        UIButton *menuButton = [self.menuButtonArray firstObject];
        // 如果外界开启了动画，则给第一个button加上放大动画。如果不这样做，外界开启动画后，第一个button是不会有放大效果的，只有点击了其它button之后才会有动画效果。
        CABasicAnimation *animation = [self enlargeAnimation];
        [menuButton.titleLabel.layer addAnimation:animation forKey:@"animation"];
    } else {
        // 遍历所有的button，如果外界关闭了动画，则将所有button上动画移除
        [self.menuButtonArray enumerateObjectsUsingBlock:^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.titleLabel.layer removeAllAnimations];
        }];
    }
}

// 开启动画
- (void)openAnimationWithButton1:(UIButton *)lastButton button2:(UIButton *)currentButton {
    CABasicAnimation *animation1 = [self enlargeAnimation];
    CABasicAnimation *animation2 = [self narrowAnimation];
    [lastButton.titleLabel.layer addAnimation:animation2 forKey:@"animation2"];
    [currentButton.titleLabel.layer addAnimation:animation1 forKey:@"animation1"];
}

// 返回放大的动画
- (CABasicAnimation *)enlargeAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue  = [NSNumber numberWithFloat:1.2f];
    animation.duration = 0.1;
    animation.repeatCount = 1;
    // 以下两个属性是让动画保持动画结束的状态
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.autoreverses = NO;
    return animation;
}

// 返回缩小动画
- (CABasicAnimation *)narrowAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.2f];
    animation.toValue  = [NSNumber numberWithFloat:1.0f];
    animation.duration = 0.1;
    animation.repeatCount = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.autoreverses = NO;
    return animation;
}


// 重写set方法，设置选中button的颜色
- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    [_selectedButton setTitleColor:selectedColor forState:UIControlStateNormal];
    _tracker.backgroundColor = selectedColor;
}

// 重写set方法，设置未选中的button颜色
- (void)setUnSelectedColor:(UIColor *)unSelectedColor {
    _unSelectedColor = unSelectedColor;
    for (UIButton *menuButton in self.menuButtonArray) {
        if (menuButton == _selectedButton) {
            continue;  // 跳过选中的那个button
        }
        [menuButton setTitleColor:unSelectedColor forState:UIControlStateNormal];
    }
}

// button点击方法
- (void)menuBtnClick:(UIButton *)sender {
    if (self.selectedButton == sender) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(pageMenu:buttonClickedAtIndex:)]) {
        [self.delegate pageMenu:self buttonClickedAtIndex:sender.tag - tagIndex];
    }
    if ([self.delegate respondsToSelector:@selector(pageMenu:buttonClickedFromIndex:toIndex:)]) {
        [self.delegate pageMenu:self buttonClickedFromIndex:self.selectedButton.tag - tagIndex toIndex:sender.tag - tagIndex ];
    }
    self.selectedButton = sender;

}

// 重写set方法,分割线是否显示
- (void)setShowBreakline:(BOOL)showBreakline{
    _showBreakline = showBreakline;
    self.breakline.hidden = !showBreakline;
}

// 设置分割线颜色
- (void)setBreaklineColor:(UIColor *)color{
    self.breakline.backgroundColor = color;
}

// 是否显示跟踪器
- (void)setShowTracker:(BOOL)showTracker {
    _showBreakline = showTracker;
    _tracker.hidden = !showTracker;
}

// 设置menuButton之间的间距
- (void)setPadding:(CGFloat)padding {
    _padding = padding;
    menuButtonX = 0.5 * padding;
    for (int i = 0; i < self.menuButtonArray.count; i++) {
        // 取出当前menuButton;
        UIButton *menuButton = _menuButtonArray[i];
        if (i > 0) {
            // 取出上一个button
            UIButton *lastButton = self.menuButtonArray[i - 1];
            // 当前button的x值等于上一个button的终结x值+间距
            menuButtonX = CGRectGetMaxX(lastButton.frame) + _padding;
        }
        [self sizeWithString:menuButton.titleLabel.text menuButton:menuButton  menuButtonX:menuButtonX];
        if (i == 0) {
            CGRect newFrame = self.tracker.frame;
            // x
            newFrame.origin.x = menuButton.frame.origin.x - 0.5 * _padding;
            // 宽
            newFrame.size.width = menuButton.frame.size.width + _padding;
            self.tracker.frame = newFrame;
        }
    }
    [self setScrollViewContentSize];
}

// 设置跟踪器的高度
- (void)settrackerHeight:(CGFloat)trackerHeight {
    _trackerHeight = trackerHeight;
    CGRect newFrame = self.tracker.frame;
    newFrame.size.height = trackerHeight;
    newFrame.origin.y = CGRectGetMaxY(_selectedButton.frame) - trackerHeight;
    self.tracker.frame = newFrame;
}

- (void)selectButtonAtIndex:(NSInteger)index{
    UIButton *selectedBtn = (UIButton *)[self.scrollView subviews][index + 1];
    [self menuBtnClick:selectedBtn];
}

- (void)followScrollViewOffsetX:(CGFloat)offsetX {
    
    CGRect newFrame = _tracker.frame;
    newFrame.origin.x = offsetX;
    _tracker.frame = newFrame;
}

- (void)makeTrackerFollowScrollViewMoveWithBeginOffset:(CGFloat)beginOffset scrollView:(UIScrollView *)scrollView {
    
    CGFloat offSetX = scrollView.contentOffset.x;
    CGFloat tempProgress = offSetX / scrollView.bounds.size.width;
    CGFloat progress = tempProgress - floor(tempProgress);
    
    NSInteger oldIndex;
    NSInteger currentIndex;
    
    if (offSetX - beginOffset >= 0) { // 向右
        oldIndex =  offSetX / scrollView.bounds.size.width;
        currentIndex = oldIndex + 1;
        if (currentIndex >= self.menuArray.count) {
            currentIndex = oldIndex - 1;
        }
        if (offSetX - beginOffset == scrollView.bounds.size.width) {// 滚动完成
            progress = 1.0;
            currentIndex = oldIndex;
        }
    } else {  // 向左
        currentIndex = offSetX / scrollView.bounds.size.width;
        oldIndex = currentIndex + 1;
        progress = 1.0 - progress;
        
    }
    
    [self moveTrackerWithProgress:progress fromIndex:oldIndex toIndex:currentIndex];
}

- (void)moveTrackerWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    UIButton *oldButton = self.menuButtonArray[fromIndex];
    UIButton *currentButton = self.menuButtonArray[toIndex];
    
    CGFloat xDistance = currentButton.frame.origin.x - oldButton.frame.origin.x;
    CGFloat wDistance = currentButton.frame.size.width - oldButton.frame.size.width;
    
    
    CGRect newFrame = self.tracker.frame;
    newFrame.origin.x = oldButton.frame.origin.x + xDistance * progress - 0.5*_padding;
    newFrame.size.width = oldButton.frame.size.width + wDistance * progress + _padding;
    self.tracker.frame = newFrame;
}

@end













