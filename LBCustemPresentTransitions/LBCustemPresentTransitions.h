//
//  ViewController.h
//  test
//
//  Created by 刘彬 on 16/7/1.
//  Copyright © 2016年 刘彬. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum {
    LBAnimationTypePresent,
    LBAnimationTypeDismiss,
} LBAnimationType;

typedef NS_ENUM(NSInteger, LBViewContentMode) {
    LBViewContentModeTop = 0,
    LBViewContentModeLeft,
    LBViewContentModeBottom,
    LBViewContentModeRight,
    LBViewContentModeCenter,
};


@interface LBCustemPresentTransitions : NSObject <UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) LBAnimationType type;
@property (nonatomic, assign) LBViewContentMode contentMode;

+(LBCustemPresentTransitions *)shareInstanse;

@end
