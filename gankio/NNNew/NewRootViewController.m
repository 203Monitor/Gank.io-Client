//
//  NewRootViewController.m
//  gankio
//
//  Created by 武国斌 on 2017/6/12.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "NewRootViewController.h"
#import "YYKit.h"

@interface NewRootViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *selectView;

@end

@implementation NewRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.selectView];
}

- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 64)];
        [_selectView setBackgroundColor:[[UIColor cyanColor] colorWithAlphaComponent:0.5]];
    }
    return _selectView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
