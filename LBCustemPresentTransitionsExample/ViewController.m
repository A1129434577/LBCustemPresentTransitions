//
//  ViewController.m
//  LBTextFieldDemo
//
//  Created by 刘彬 on 2019/9/24.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "LBCustemPresentTransitions.h"
#import "TestViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray<NSString *> *_textArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"LBCustemPresentTransitions";
    _textArray = @[@"从上面推出",@"从左边推出",@"从下面推出",@"从中间推出",@"从右推出"];
    
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
    
    LBCustemPresentTransitions *transitions = [LBCustemPresentTransitions shareInstanse];
    NSString *text = _textArray[indexPath.row];
    if ([text containsString:@"上"]) {
        transitions.contentMode = LBViewContentModeTop;
    }else if ([text containsString:@"左"]) {
        transitions.contentMode = LBViewContentModeLeft;
    }else if ([text containsString:@"下"]) {
        transitions.contentMode = LBViewContentModeBottom;
    }else if ([text containsString:@"右"]) {
        transitions.contentMode = LBViewContentModeRight;
    }else if ([text containsString:@"中"]) {
        transitions.contentMode = LBViewContentModeCenter;
    }
    TestViewController *presentVC = [[TestViewController alloc] init];

    if ([text containsString:@"下"]) {
        UINavigationController *presentNaVC = [[UINavigationController alloc] initWithRootViewController:presentVC];
        presentNaVC.modalPresentationStyle = UIModalPresentationCustom;
        presentNaVC.transitioningDelegate = transitions;
        [self presentViewController:presentNaVC animated:YES completion:nil];
    }else{
        presentVC.modalPresentationStyle = UIModalPresentationCustom;
        presentVC.transitioningDelegate = transitions;
        [self presentViewController:presentVC animated:YES completion:nil];
    }
}

@end
