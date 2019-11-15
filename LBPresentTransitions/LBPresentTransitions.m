//
//  ViewController.m
//  test
//
//  Created by 刘彬 on 16/7/1.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import "LBPresentTransitions.h"
typedef enum {
    LBAnimationTypePresent,
    LBAnimationTypeDismiss,
} LBTransitionsAnimationType;


@interface LBPresentTransitions ()<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>
@property (nonatomic,assign)LBTransitionsAnimationType type;
@property (nonatomic,strong)UIView *coverView;
@property (nonatomic,weak)  UIViewController *modalViewVC;
@end


@implementation LBPresentTransitions
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tapCoverViewDismiss = YES;
        self.coverViewType = LBTransitionsCoverViewAlpha0_5;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //The view controller's view that is presenting the modal view
    UIView *containerView = [transitionContext containerView];
    //    containerView: <UITransitionView: 0x7ffa4a428910; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x6000020e1b40>>
    
    UIViewController *modalViewVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _modalViewVC = modalViewVC;
    //    modalViewVC.view: <UILayoutContainerView: 0x7ffa4a618770; frame = (0 0; 375 667); clipsToBounds = YES; autoresize = W+H; gestureRecognizers = <NSArray: 0x600002efbc60>; layer = <CALayer: 0x6000020bff40>>
    
    UIView *contentView;
    if ([modalViewVC isKindOfClass:UINavigationController.self]) {
        contentView = ((UINavigationController *)modalViewVC).topViewController.view;
    }else if ([modalViewVC isKindOfClass:UIViewController.self]){
        contentView = modalViewVC.view;
    }
    //contentView: <UIView: 0x7ffa4a615ba0; frame = (0 0; 250 44); autoresize = W+H; layer = <CALayer: 0x6000020bfea0>>

    if (self.type == LBAnimationTypePresent) {
        _coverView = [[UIView alloc] initWithFrame:containerView.bounds];
        _coverView.alpha = 0;
        [containerView addSubview:_coverView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTopGestureAction)];
        [_coverView addGestureRecognizer:tapGesture];
        
        UIVisualEffectView *effectView;
        if ((_coverViewType & LBTransitionsCoverViewEffectDark)||
            (_coverViewType & LBTransitionsCoverViewEffectExtraDark)||
            (_coverViewType & LBTransitionsCoverViewEffectLight)||
            (_coverViewType & LBTransitionsCoverViewEffectExtraLight)) {
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            // 磨砂视图
            effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            effectView.frame = _coverView.bounds;
            [_coverView addSubview:effectView];
        }
        CGFloat alpha = 1.f;
        if (_coverViewType & LBTransitionsCoverViewTypeNone) {
            alpha = 0.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_1) {
            alpha = log(LBTransitionsCoverViewAlpha0_1)/log(2)/10.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_2){
            alpha = log(LBTransitionsCoverViewAlpha0_2)/log(2)/10.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_3){
            alpha = log(LBTransitionsCoverViewAlpha0_3)/log(2)/10.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_4){
            alpha = log(LBTransitionsCoverViewAlpha0_4)/log(2)/10.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_5){
            alpha = log(LBTransitionsCoverViewAlpha0_5)/log(2)/10.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_6){
            alpha = log(LBTransitionsCoverViewAlpha0_6)/log(2)/10.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_7){
            alpha = log(LBTransitionsCoverViewAlpha0_7)/log(2)/10.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_8){
            alpha = log(LBTransitionsCoverViewAlpha0_8)/log(2)/10.f;
        }
        if (_coverViewType & LBTransitionsCoverViewAlpha0_9){
            alpha = log(LBTransitionsCoverViewAlpha0_9)/log(2)/10.f;
        }
        
        if (effectView) {
            effectView.alpha = alpha;
        }else{
            _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
        }
        
        //The modal view itself
        switch (self.contentMode) {
            case LBTransitionsContentModeTop:
                modalViewVC.view.frame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(contentView.frame))/2, -CGRectGetHeight(contentView.frame), CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                break;
            case LBTransitionsContentModeLeft:
                modalViewVC.view.frame = CGRectMake(-CGRectGetWidth(contentView.frame), (CGRectGetHeight(containerView.frame)-CGRectGetHeight(contentView.frame))/2, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                break;
            case LBTransitionsContentModeBottom:
                modalViewVC.view.frame = CGRectMake((CGRectGetWidth(containerView.frame)-CGRectGetWidth(contentView.frame))/2, CGRectGetHeight(containerView.frame), CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                break;
            case LBTransitionsContentModeRight:
                modalViewVC.view.frame = CGRectMake(CGRectGetWidth(containerView.frame), (CGRectGetHeight(containerView.frame)-CGRectGetHeight(contentView.frame))/2, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
                break;
            case LBTransitionsContentModeCenter:
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
                case LBTransitionsContentModeTop:
                    modalViewVC.view.frame = CGRectMake(CGRectGetMinX(modalViewVC.view.frame), 0, CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBTransitionsContentModeLeft:
                    modalViewVC.view.frame = CGRectMake(0, CGRectGetMinY(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBTransitionsContentModeBottom:
                    modalViewVC.view.frame = CGRectMake(CGRectGetMinX(modalViewVC.view.frame), CGRectGetHeight(containerView.frame)-CGRectGetHeight(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));

                    break;
                case LBTransitionsContentModeRight:
                    modalViewVC.view.frame = CGRectMake(CGRectGetWidth(containerView.frame)-CGRectGetWidth(modalViewVC.view.frame), CGRectGetMinY(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBTransitionsContentModeCenter:
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
                case LBTransitionsContentModeTop:
                    modalViewVC.view.frame = CGRectMake(CGRectGetMinX(modalViewVC.view.frame), -CGRectGetHeight(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBTransitionsContentModeLeft:
                    modalViewVC.view.frame = CGRectMake(-CGRectGetWidth(modalViewVC.view.frame), CGRectGetMinY(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBTransitionsContentModeBottom:
                    modalViewVC.view.frame = CGRectMake(CGRectGetMinX(modalViewVC.view.frame), CGRectGetHeight(containerView.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    
                    break;
                case LBTransitionsContentModeRight:
                    modalViewVC.view.frame = CGRectMake(CGRectGetWidth(containerView.frame), CGRectGetMinY(modalViewVC.view.frame), CGRectGetWidth(modalViewVC.view.frame), CGRectGetHeight(modalViewVC.view.frame));
                    break;
                case LBTransitionsContentModeCenter:
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
-(void)coverViewTopGestureAction{
    if (self.tapCoverViewDismiss) {
        [self.modalViewVC dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
