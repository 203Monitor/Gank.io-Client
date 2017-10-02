//
//  ViewController.m
//  gankio
//
//  Created by 武国斌 on 16/9/8.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "DayController.h"
#import "NetWorkUtil.h"
#import "Common.h"
#import "Api.h"
#import "ItemController.h"
#import "MJRefresh.h"

@interface DayController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tv;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation DayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY/MM/dd"];
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
//    NSLog(@"locationString:%@",locationString);
    
    self.datas = @[];
    self.tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    [self.tv setDelegate:self];
    [self.tv setDataSource:self];
    [self.view addSubview:self.tv];
    self.tv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    [self.tv.mj_header beginRefreshing];
//    [self urlstring:@"http://gank.io/2016/09/22"];
}

- (void)getData {
    [NetWorkUtil getWithUrl:API_HISTORY andCallBack:^(NSDictionary *result) {
        NSMutableArray *res = [NSMutableArray array];
        for (NSString *str in result[@"results"]) {
            [res addObject:[str stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
        }
        self.datas = [NSArray arrayWithArray:res];
        [self.tv reloadData];
        [self.tv.mj_header endRefreshing];
    }];
}

//- (void)urlstring:(NSString*)strurl{
//    [NetWorkUtil getDomWithUrl:strurl andCallBack:^(id result) {
//        ;
//    }];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return [self.datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"date";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ItemController *ic = [[ItemController alloc] init];
    ic.suffix = self.datas[indexPath.row];
    [self.navigationController pushViewController:ic animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController setTitle:@"Gank.io"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
