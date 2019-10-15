# LBCustemPresentTransitions
```objc
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
```
![](https://github.com/A1129434577/LBCustemPresentTransitions/blob/master/LBCustemPresentTransitions.gif?raw=true)
