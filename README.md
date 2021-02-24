# LBCustemPresentTransitions
# 自定义Present转场效果，可以从上、左、下、右、中五个位置Present，是抽屉式弹出View和中间弹窗alertView样式的首选，支持任何自定义动画。
# 导入方式
```ruby
pod 'LBPresentTransitions'
```
```objc
    _transitions = [LBPresentTransitions new];
    _transitions.tapCoverViewDismiss = YES;
    _transitions.coverViewType = LBTransitionsCoverViewAlpha0_5|LBTransitionsCoverViewEffectDark;
    NSString *text = _textArray[indexPath.row];
    if ([text containsString:@"上"]) {
        _transitions.contentMode = LBTransitionsContentModeTop;
    }else if ([text containsString:@"左"]) {
        _transitions.contentMode = LBTransitionsContentModeLeft;
    }else if ([text containsString:@"下"]) {
        _transitions.contentMode = LBTransitionsContentModeBottom;
    }else if ([text containsString:@"右"]) {
        _transitions.contentMode = LBTransitionsContentModeRight;
    }else if ([text containsString:@"中"]) {
        _transitions.contentMode = LBTransitionsContentModeCenter;
        _transitions.customPresentAnimation = ^(UIView * _Nonnull coverView, UIView * _Nonnull contentView, void (^ _Nonnull completion)(BOOL)) {
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:0 animations:^{
                coverView.alpha = 1.0;
                contentView.transform = CGAffineTransformIdentity;
            } completion:completion];
        };
    }
    TestViewController *presentVC = [[TestViewController alloc] init];
    
if ([text containsString:@"下"]) {
            UINavigationController *presentNaVC = [[UINavigationController alloc] initWithRootViewController:presentVC];
            presentNaVC.modalPresentationStyle = UIModalPresentationCustom;
            presentNaVC.transitioningDelegate = _transitions;
            [self presentViewController:presentNaVC animated:YES completion:nil];
        }else{
            presentVC.modalPresentationStyle = UIModalPresentationCustom;
            presentVC.transitioningDelegate = _transitions;
            [self presentViewController:presentVC animated:YES completion:nil];
        }
```
![](https://github.com/A1129434577/LBCustemPresentTransitions/blob/master/LBCustemPresentTransitions.gif?raw=true)
