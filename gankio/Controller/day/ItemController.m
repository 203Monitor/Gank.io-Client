//
//  ItemController.m
//  gankio
//
//  Created by 武国斌 on 16/9/8.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "ItemController.h"
#import "ItemModel.h"
#import "Common.h"
#import "NetWorkUtil.h"
#import "Api.h"
#import "ItemCell.h"
#import "WebViewController.h"
#import "UIImageView+WebCache.h"

@interface ItemController () <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *datas;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, copy) NSString *temp;

@end

@implementation ItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = self.suffix;
    self.datas = @{};
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    NSString *newApi = [NSString stringWithFormat:@"%@%@",API_ONEDAY,self.suffix];
    [NetWorkUtil getWithUrl:newApi andCallBack:^(NSDictionary *result) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in result[@"category"]) {
            NSMutableArray *res = [NSMutableArray array];
            for (NSDictionary *data in result[@"results"][key]) {
                [res addObject:[ItemModel setModel:data]];
            }
            [dic setObject:res forKey:key];
        }
        self.datas = [NSDictionary dictionaryWithDictionary:dic];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.datas allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas[[self.datas allKeys][section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"item";
    ItemModel *model = self.datas[[self.datas allKeys][indexPath.section]][indexPath.row];
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ItemCell" owner:self options:nil] firstObject];
    }
    
    [cell.title setText:model.desc];
    [cell.sender setText:model.who];
//    NSArray *arr = (NSArray *)model.images;
//    [cell.image sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:nil options:(SDWebImageRetryFailed) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//    }];
//    [cell.image setContentMode:UIViewContentModeScaleAspectFit];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ItemModel *model = self.datas[[self.datas allKeys][indexPath.section]][indexPath.row];
    WebViewController *wvc = [[WebViewController alloc] init];
    [wvc setUrl:model.url];
    [wvc setTitle:[NSString stringWithFormat:@"%@ : %@",model.type,model.desc]];
    [wvc setType:model.type];
    [self.navigationController pushViewController:wvc animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.datas allKeys][section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//     ItemModel *model = self.datas[[self.datas allKeys][indexPath.section]][indexPath.row];
//     if(model.images) {
//        return 304;
//     }else {
         return 100;
//     }
}

@end
