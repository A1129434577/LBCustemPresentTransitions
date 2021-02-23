//
//  ViewController.m
//  LBTextFieldDemo
//
//  Created by 刘彬 on 2019/9/24.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "LBPresentTransitions.h"
#import "TestViewController.h"
#import "LBPresentTransitionsTestPushVC1.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray<NSString *> *_textArray;
    LBPresentTransitions *_transitions;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"LBCustemPresentTransitions";
    _textArray = @[@"从上面推出",@"从左边推出",@"从下面推出",@"从中间推出",@"从右推出",@"弹窗再push"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _textArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"LBCustemPresentTransitions";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = _textArray[indexPath.row];
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    
    if ([text containsString:@"推出"]) {
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
    }else if ([text containsString:@"弹窗再push"]) {
        LBPresentTransitionsTestPushVC1 *presentTransitionsTestVC = [[LBPresentTransitionsTestPushVC1 alloc] init];
        UINavigationController *presentTransitionsTestNaVC = [[UINavigationController alloc] initWithRootViewController:presentTransitionsTestVC];
        presentTransitionsTestNaVC.modalPresentationStyle = UIModalPresentationCustom;
        presentTransitionsTestNaVC.transitioningDelegate = presentTransitionsTestVC.transitions;
        
        [self presentViewController:presentTransitionsTestNaVC animated:YES completion:NULL];
    }
    
}

@end
