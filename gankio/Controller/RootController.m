//
//  RootController.m
//  gankio
//
//  Created by 武国斌 on 16/9/9.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "RootController.h"
#import "DayController.h"
#import "SearchController.h"
#import "CategoryController.h"

@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DayController *day = [[DayController alloc] init];
//    day.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"day" image:[[UIImage imageNamed:@"tab1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]  tag:1];
    day.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"day" image:[[UIImage imageNamed:@"tab2_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab1_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    SearchController *search = [[SearchController alloc] init];
//    search.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"search" image:[[UIImage imageNamed:@"tab2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:2];
    search.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"search" image:[[UIImage imageNamed:@"tab2_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab1_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    CategoryController *category = [[CategoryController alloc] init];
//    category.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"category" image:[[UIImage imageNamed:@"tab3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:3];
    category.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"category" image:[[UIImage imageNamed:@"tab2_3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab1_3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 分栏控制器会自动将其管理的视图控制器的分栏按钮(UITabBarItem)放到分栏上显示
    self.viewControllers = @[day, search, category];
    // 取到分栏控制器的分栏
    UITabBar *tabBar = self.tabBar;
    // 设置分栏的风格
    tabBar.barStyle = UIBarStyleBlack;
    // 是否透明
    tabBar.translucent = NO;
    // 设置分栏的前景颜色
    tabBar.barTintColor = [UIColor whiteColor];
    // 设置分栏元素项的颜色
    tabBar.tintColor = [UIColor blackColor];
    
}

@end
