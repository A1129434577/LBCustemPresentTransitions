//
//  LBPresentTransitionsTestVC.m
//  TestDome
//
//  Created by 刘彬 on 2020/3/24.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBPresentTransitionsTestPushVC1.h"
#import "LBPresentTransitionsTestPushVC2.h"

@interface LBPresentTransitionsTestPushVC1 ()

@end

@implementation LBPresentTransitionsTestPushVC1

- (instancetype)init
{
    self = [super init];
    if (self) {
        _transitions = [LBPresentTransitions new];
        _transitions.contentMode = LBTransitionsContentModeCenter;
        _transitions.tapCoverViewDismiss = YES;
    }
    return self;
}



-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.layer.cornerRadius = 8;
    
    self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds)-30*2, 300);
    
    
    UIButton *nextPageBtn = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.bounds)-80)/2, 60, 80, 40)];
    nextPageBtn.backgroundColor = [UIColor magentaColor];
    [nextPageBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [nextPageBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPageBtn];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.view.frame = CGRectMake(CGRectGetMinX(self.navigationController.view.frame), (CGRectGetHeight([UIScreen mainScreen].bounds)-300)/2, CGRectGetWidth(self.navigationController.view.frame), 300);
    }];
}

-(void)nextPage:(UIButton *)sender{
    LBPresentTransitionsTestPushVC2 *presentTransitionsTestVC2 = [[LBPresentTransitionsTestPushVC2 alloc] init];
    [self.navigationController pushViewController:presentTransitionsTestVC2 animated:YES];
    
}

@end
