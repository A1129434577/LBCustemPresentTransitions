//
//  ViewController.h
//  test
//
//  Created by 刘彬 on 16/7/1.
//  Copyright © 2016年 刘彬. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LBTransitionsContentMode) {
    LBTransitionsContentModeTop = 0,
    LBTransitionsContentModeLeft,
    LBTransitionsContentModeBottom,
    LBTransitionsContentModeRight,
    LBTransitionsContentModeCenter,
};

typedef NS_OPTIONS(NSUInteger, LBTransitionsCoverViewType) {
    //不带磨砂效果的
    LBTransitionsCoverViewAlpha0_1 = 1<<1,//alpha0.1
    LBTransitionsCoverViewAlpha0_2 = 1<<2,
    LBTransitionsCoverViewAlpha0_3 = 1<<3,
    LBTransitionsCoverViewAlpha0_4 = 1<<4,
    LBTransitionsCoverViewAlpha0_5 = 1<<5,
    LBTransitionsCoverViewAlpha0_6 = 1<<6,
    LBTransitionsCoverViewAlpha0_7 = 1<<7,
    LBTransitionsCoverViewAlpha0_8 = 1<<8,
    LBTransitionsCoverViewAlpha0_9 = 1<<9,
    //带磨砂效果的
    LBTransitionsCoverViewEffectDark       = 2<<10,
    LBTransitionsCoverViewEffectExtraDark  = 2<<11,
    LBTransitionsCoverViewEffectLight      = 2<<12,
    LBTransitionsCoverViewEffectExtraLight = 2<<13,
    //背景无任何遮盖
    LBTransitionsCoverViewTypeNone = 3<<14,
};
@interface LBPresentTransitions : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic,assign)LBTransitionsContentMode contentMode;
@property (nonatomic,assign)LBTransitionsCoverViewType coverViewType;
@property (nonatomic,assign)BOOL tapCoverViewDismiss;//点击空白让viewControllerDismiss
@property (nonatomic,copy,nullable) void(^coverViewTopGestureActionHandle)(void);
@property (nonatomic,copy,nullable) void(^customPresentAnimation)(UIView * _Nonnull coverView, UIView * _Nonnull contentView, void (^ _Nonnull completion)(BOOL finished));//你也可以不用预设present动画，在block里写自己的动画(注意这里的completion必须在你实现的动画结束时调用以使vc有正常的生命周期)
@property (nonatomic,copy,nullable) void(^customDismissAnimation)(UIView * _Nonnull coverView, UIView * _Nonnull contentView, void (^ _Nonnull completion)(BOOL finished));//你也可以不用预设dismiss动画，在block里写自己的动画(注意这里的completion必须在你实现的动画结束时调用以使vc有正常的生命周期)
@end
