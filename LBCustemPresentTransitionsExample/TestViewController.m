//
//  TestViewController.m
//  LBCustemPresentTransitionsExample
//
//  Created by 刘彬 on 2019/9/27.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "TestViewController.h"
#import "LBPresentTransitions.h"
@interface TestViewController ()

@end

@implementation TestViewController
- (void)loadView{
    [super loadView];
    LBPresentTransitions *transitions = (LBPresentTransitions *)self.transitioningDelegate;
    if (!transitions) {
        transitions = (LBPresentTransitions *)self.navigationController.transitioningDelegate;
    }
    switch (transitions.contentMode) {
        case LBTransitionsContentModeTop:
        case LBTransitionsContentModeBottom:
            self.view.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 250);
            break;
        case LBTransitionsContentModeLeft:
        case LBTransitionsContentModeRight:
            self.view.bounds = CGRectMake(0, 0, 200, CGRectGetHeight(self.view.bounds)-200);
            break;
        case LBTransitionsContentModeCenter:
            self.view.bounds = CGRectMake(0, 0, 250, 250);
            break;
            
        default:
            break;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 10;
    self.navigationController.view.layer.cornerRadius = 10;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-80)/2, (CGRectGetHeight(self.view.frame)-80)/2, 80, 80)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor grayColor];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
}
-(void)dismiss{
    [self.navigationController?self.navigationController:self dismissViewControllerAnimated:YES completion:nil];
}

@end
