//
//  ViewController.m
//  test
//
//  Created by 刘彬 on 16/7/1.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import "LBCustemPresentTransitions.h"

@interface LBCustemPresentTransitions ()
@property (nonatomic,strong)UIView *coverView;;
@end

@implementation LBCustemPresentTransitions

+(LBCustemPresentTransitions *)shareInstanse{
    static LBCustemPresentTransitions *modelAnimation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modelAnimation = [[LBCustemPresentTransitions alloc] init];
    });
    return modelAnimation;
}

#pragma mark - UIViewControllerAnimatedTransitioning
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //The view controller's view that is presenting the modal view
    UIView *containerView = [transitionContext containerView];
    //    containerView: <UITransitionView: 0x7ffa4a428910; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x6000020e1b40>>
    
    UINavigationController *modalViewVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //    modalViewVC.view: <UILayoutContainerView: 0x7ffa4a618770; frame = (0 0; 375 667); clipsToBounds = YES; autoresize = W+H; gestureRecognizers = <NSArray: 0x600002efbc60>; layer = <CALayer: 0x6000020bff40>>
    
    UIView *contentView;
    if ([modalViewVC isKindOfClass:NSClassFromString(@"UINavigationController")]) {
        contentView = modalViewVC.topViewController.view;
    }else if ([modalViewVC isKindOfClass:NSClassFromString(@"UIViewController")]){
        contentView = modalViewVC.view;
    }
    //contentView: <UIView: 0x7ffa4a615ba0; frame = (0 0; 250 44); autoresize = W+H; layer = <CALayer: 0x6000020bfea0>>
    

    if (self.type == LBAnimationTypePresent) {
        
        //View to darken the area behind the modal view
        if (!_coverView) {
            _coverView = [[UIView alloc] initWithFrame:containerView.bounds];
            
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            // 磨砂视图
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            effectView.frame = _coverView.bounds;
            effectView.alpha = 0.5;
            [_coverView addSubview:effectView];
        }else{
            _coverView.frame = containerView.frame;
        }
        [containerView addSubview:_coverView];
        
        
        //The modal view itself
        switch (self.contentMode) {
            case LBViewContentModeTop:
                modalViewVC.view.frame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(contentView.frame))/2, -CGRectGetHeight(contentView.frame), CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                break;
            case LBViewContentModeLeft:
                modalViewVC.view.frame = CGRectMake(-CGRectGetWidth(contentView.frame), (CGRectGetHeight(containerView.frame)-CGRectGetHeight(contentView.frame))/2, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                break;
            case LBViewContentModeBottom:
                modalViewVC.view.frame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(contentView.frame))/2, CGRectGetHeight(containerView.frame), CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                break;
            case LBViewContentModeRight:
                modalViewVC.view.frame = CGRectMake(CGRectGetWidth(containerView.frame), (CGRectGetHeight(containerView.frame)-CGRectGetHeight(contentView.frame))/2, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                break;
            case LBViewContentModeCenter:
                modalViewVC.view.frame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(contentView.frame))/2, (CGRectGetHeight(containerView.frame)-CGRectGetHeight(contentView.frame))/2, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                modalViewVC.view.transform = CGAffineTransformMakeScale(0, 0);
                break;
                
            default:
                break;
        }
        [containerView addSubview:modalViewVC.view];
        
        typeof(self) __weak weakSelf = self;
        //Animate using spring animation
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            weakSelf.coverView.alpha = 1.0;
            switch (weakSelf.contentMode) {
                case LBViewContentModeTop:
                    modalViewVC.view.frame = CGRectMake(CGRectGetMinX(modalViewVC.view.frame), 0, CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBViewContentModeLeft:
                    modalViewVC.view.frame = CGRectMake(0, CGRectGetMinY(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBViewContentModeBottom:
                    modalViewVC.view.frame = CGRectMake(CGRectGetMinX(modalViewVC.view.frame), CGRectGetHeight(containerView.frame)-CGRectGetHeight(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));

                    break;
                case LBViewContentModeRight:
                    modalViewVC.view.frame = CGRectMake(CGRectGetWidth(containerView.frame)-CGRectGetWidth(modalViewVC.view.frame), CGRectGetMinY(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBViewContentModeCenter:
                    modalViewVC.view.transform = CGAffineTransformIdentity;
                    break;
                    
                default:
                    break;
            }
        }completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];

    } else if (self.type == LBAnimationTypeDismiss) {
        //The modal view itself
        modalViewVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        typeof(self) __weak weakSelf = self;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:0 animations:^{
            weakSelf.coverView.alpha = 0.0;
            switch (weakSelf.contentMode) {
                case LBViewContentModeTop:
                    modalViewVC.view.frame = CGRectMake(CGRectGetMinX(modalViewVC.view.frame), -CGRectGetHeight(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBViewContentModeLeft:
                    modalViewVC.view.frame = CGRectMake(-CGRectGetWidth(modalViewVC.view.frame), CGRectGetMinY(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBViewContentModeBottom:
                    modalViewVC.view.frame = CGRectMake(CGRectGetMinX(modalViewVC.view.frame), CGRectGetHeight(containerView.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    
                    break;
                case LBViewContentModeRight:
                    modalViewVC.view.frame = CGRectMake(CGRectGetWidth(containerView.frame), CGRectGetMinY(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBViewContentModeCenter:
                    modalViewVC.view.transform = CGAffineTransformMakeScale(0, 0);
                    break;
                    
                default:
                    break;
            }

        } completion:^(BOOL finished) {
            [weakSelf.coverView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.type = LBAnimationTypePresent;
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.type = LBAnimationTypeDismiss;
    return self;
}

#pragma mark - Navigation Controller Delegate
//当前已经自定义转场动画的UINavigationController再次push或者pop的时候会走这个方法
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    __block CGFloat modelViewHeight = 0.f;
    [toVC.view.subviews enumerateObjectsUsingBlock:^(UIView  *contentView, NSUInteger idx, BOOL * _Nonnull stop) {
        modelViewHeight += CGRectGetHeight(contentView.bounds);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        navigationController.view.frame = CGRectMake(CGRectGetMinX(navigationController.view.frame), (CGRectGetHeight([UIScreen mainScreen].bounds)-modelViewHeight)/2, CGRectGetWidth(navigationController.view.frame), modelViewHeight);
    }];
    
    [toVC loadView];
    return nil;
}

@end
