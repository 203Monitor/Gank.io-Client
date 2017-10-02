//
//  SearchController.m
//  gankio
//
//  Created by 武国斌 on 16/9/9.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "SearchController.h"
#import "JTSlideShadowAnimation.h"
#import "Common.h"
#import "Api.h"
#import "NetWorkUtil.h"
#import "SearchModel.h"
#import "WebViewController.h"
#import "YYKit.h"

@interface SearchController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) JTSlideShadowAnimation *shadowAnimation;
@property (nonatomic, strong) UITextField *searchKey;//顶部输入框
@property (nonatomic, strong) UIButton *category;//分类按钮
@property (nonatomic, strong) NSArray *categories;//全部分类
@property (nonatomic, assign) BOOL show;//是否显示分类选择视图
@property (nonatomic, strong) UITableView *tableView;//显示搜索结果
@property (nonatomic, strong) NSArray *datas;//搜索结果
@property (nonatomic, assign) int count;//category计数

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.count = 0;
    self.datas = @[];
    self.show = NO;
    self.categories = @[@"iOS",@"Android",@"休息视频",@"福利",@"拓展资源",@"前端",@"瞎推荐",@"App",@"all"];
    
    [self renderNavigator];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49) style:UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 65)];
//    [path addLineToPoint:CGPointMake(kScreenWidth, 65)];
//    path.lineWidth = 2.0f;
//    [path stroke];
}

- (void)renderNavigator {
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [bar setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    //输入框背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 27, LAYOUTSCALE(190), 30)];
    [bgView setBackgroundColor:[UIColor grayColor]];
    [bgView.layer setCornerRadius:8];
    [bar addSubview:bgView];
    //输入框
    self.searchKey = [[UITextField alloc] initWithFrame:CGRectMake(30, 27, LAYOUTSCALE(170), 30)];
    [self.searchKey setBackgroundColor:[UIColor grayColor]];
    [self.searchKey setTextColor:[UIColor whiteColor]];
    [self.searchKey setFont:[UIFont systemFontOfSize:20]];
    [self.searchKey.layer setCornerRadius:8];
    [self.searchKey setTextAlignment:0];
    [bar addSubview:self.searchKey];
    //分类按钮
    self.category = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.category setBackgroundColor:[UIColor brownColor]];
    [self.category.layer setCornerRadius:8];
    [self.category setFrame:CGRectMake(self.searchKey.right+10, 27, LAYOUTSCALE(93), 30)];
    [self.category setTitle:self.categories[self.count] forState:UIControlStateNormal];
    [self.category setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.category setUserInteractionEnabled:NO];
    [bar addSubview:self.category];
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(self.searchKey.right, 0, LAYOUTSCALE(93)+20, 64)];
    [bigView setBackgroundColor:[UIColor clearColor]];
    [bar addSubview:bigView];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(categoryChange:)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [bigView addGestureRecognizer:right];
    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(categoryChange:)];
    [left setDirection:UISwipeGestureRecognizerDirectionLeft];
    [bigView addGestureRecognizer:left];
    
    //搜索按钮
    UIButton *doSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    [doSearch setBackgroundColor:[UIColor grayColor]];
    [doSearch setTitle:@"搜索" forState:UIControlStateNormal];
    [self.category setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doSearch setFrame:CGRectMake(self.category.right+10, 27, LAYOUTSCALE(56), 30)];
    [doSearch.layer setCornerRadius:8];
    [doSearch addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:doSearch];
    
    [self.view addSubview:bar];
}

- (void)doSearch {
    [self dismissKeyBoardOn:self.view];
    [NetWorkUtil getWithUrl:SEARCH(self.searchKey.text, self.category.titleLabel.text, 1) andCallBack:^(NSDictionary *result) {
        NSMutableArray *res = [NSMutableArray array];
        for (NSDictionary *data in result[@"results"]) {
            [res addObject:[SearchModel setModel:data]];
        }
        self.datas = [NSArray arrayWithArray:res];
        [self.tableView reloadData];
    }];
}

- (void)categoryChange:(UISwipeGestureRecognizer *)sender {
    if ((unsigned long)sender.direction == 1) {
        --self.count;
    }else {
        ++self.count;
    }
    if (self.count >= 9) {
        self.count = 0;
    }else if(self.count <= -1) {
        self.count = 8;
    }
    [self.category setTitle:self.categories[self.count] forState:UIControlStateNormal];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"search";
    SearchModel *model = self.datas[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = model.desc;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SearchModel *model = self.datas[indexPath.row];
    WebViewController *wvc = [[WebViewController alloc] init];
    [wvc setUrl:model.url];
    [wvc setTitle:[NSString stringWithFormat:@"%@ : %@",model.type,model.desc]];
    [wvc setType:model.type];
    [self.navigationController pushViewController:wvc animated:YES];
}

- (void)developing {
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
    [self.tabBarController setTitle:@"Search"];
//    [self.shadowAnimation start];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.shadowAnimation stop];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
