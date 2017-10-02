//
//  BaseViewController.m
//  gankio
//
//  Created by 武国斌 on 16/9/12.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self dismissKeyBoard:self];
}

- (void)dismissKeyBoardOn:(UIView *)view {
    if (view.subviews.count > 0) {
        for (UIView *subview in view.subviews) {
            [subview resignFirstResponder];
            [self dismissKeyBoardOn:subview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
