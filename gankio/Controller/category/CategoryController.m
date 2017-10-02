//
//  CategoryController.m
//  gankio
//
//  Created by 武国斌 on 16/9/9.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "CategoryController.h"
#import "JTSlideShadowAnimation.h"

@interface CategoryController ()

@property (strong, nonatomic) JTSlideShadowAnimation *shadowAnimation;

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *tip = [[UILabel alloc] initWithFrame:self.view.bounds];
    [tip setText:@"developing..."];
    [tip setTextAlignment:1];
    [tip setFont:[UIFont systemFontOfSize:30]];
    [tip setTextColor:[UIColor grayColor]];
    [self.view addSubview:tip];
    
    self.shadowAnimation = [JTSlideShadowAnimation new];
    self.shadowAnimation.animatedView = tip;
    self.shadowAnimation.shadowWidth = 40.;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController setTitle:@"Category"];
    [self.shadowAnimation start];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.shadowAnimation stop];
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
