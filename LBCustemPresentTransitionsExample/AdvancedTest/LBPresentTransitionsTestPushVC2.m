//
//  LBPresentTransitionsTestVC2.m
//  TestDome
//
//  Created by 刘彬 on 2020/3/24.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBPresentTransitionsTestPushVC2.h"

@interface LBPresentTransitionsTestPushVC2 ()

@end

@implementation LBPresentTransitionsTestPushVC2
-(void)loadView{
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.view.frame = CGRectMake(CGRectGetMinX(self.navigationController.view.frame), (CGRectGetHeight([UIScreen mainScreen].bounds)-400)/2, CGRectGetWidth(self.navigationController.view.frame), 400);
    }];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
