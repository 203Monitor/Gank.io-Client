//
//  SearchController.m
//  gankio
//
//  Created by 武国斌 on 16/9/9.
//  Copyright © 2016年 武国斌. All rights reserved.
//

/*

#import "SearchController.h"
#import "JTSlideShadowAnimation.h"
#import "Common.h"
#import "Api.h"
#import "NetWorkUtil.h"
#import "SearchModel.h"
#import "WebViewController.h"

@interface SearchController () <UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) JTSlideShadowAnimation *shadowAnimation;
@property (nonatomic, strong) UITextField *searchKey;
@property (nonatomic, strong) UIButton *submit;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self developing];
    
    self.datas = @[];
    self.show = NO;
    self.titles = @[@"iOS",@"Android",@"休息视频",@"福利",@"拓展资源",@"前端",@"瞎推荐",@"App",@"all"];
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [bar setBackgroundColor:[UIColor cyanColor]];
    
    //    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
    //    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //    [item setLeftBarButtonItem:leftBtn];
    //    [bar pushNavigationItem:item animated:YES];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 27, WIDTH*0.7, 30)];
    [bgView setBackgroundColor:[UIColor grayColor]];
    [bgView.layer setCornerRadius:8];
    [bar addSubview:bgView];
    
    self.searchKey = [[UITextField alloc] initWithFrame:CGRectMake(30, 27, WIDTH*0.7-20, 30)];
    [self.searchKey setBackgroundColor:[UIColor grayColor]];
    [self.searchKey setTextColor:[UIColor whiteColor]];
    [self.searchKey setFont:[UIFont systemFontOfSize:20]];
    [self.searchKey.layer setCornerRadius:8];
    [self.searchKey setTextAlignment:0];
    [bar addSubview:self.searchKey];
    
    self.submit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submit setBackgroundColor:[UIColor brownColor]];
    [self.submit.layer setCornerRadius:8];
    [self.submit setFrame:CGRectMake(WIDTH*0.7+20, 27, WIDTH*0.2+10, 30)];
    [self.submit setTitle:@"ios" forState:UIControlStateNormal];
    [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submit addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *dp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCategory)];
    [dp setNumberOfTapsRequired:2];
    [self.submit addGestureRecognizer:dp];
    [bar addSubview:self.submit];
    
    [self.view addSubview:bar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49) style:UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 100)];
    [self.picker setDelegate:self];
    [self.picker setDataSource:self];
    [self.view addSubview:self.picker];
}

- (void)doSearch {
    //    [SEARCH(self.searchKey.text, self.submit.titleLabel.text, 1) stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]
    //    [SEARCH(self.searchKey.text, self.submit.titleLabel.text, 1) stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//    [self dismissKB];
    [NetWorkUtil getWithUrl:[SEARCH(self.searchKey.text, self.submit.titleLabel.text, 1) stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] andCallBack:^(NSDictionary *result) {
        NSMutableArray *res = [NSMutableArray array];
        for (NSDictionary *data in result[@"results"]) {
            [res addObject:[SearchModel setModel:data]];
        }
        self.datas = [NSArray arrayWithArray:res];
        [self.tableView reloadData];
    }];
}

- (void)changeCategory {
    CGPoint temp = self.picker.center;
    if (self.show) {
        [UIView animateWithDuration:1.0 animations:^{
            [self.picker setCenter:CGPointMake(temp.x, temp.y+100)];
        } completion:^(BOOL finished) {
            self.show = NO;
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            [self.picker setCenter:CGPointMake(temp.x, temp.y-100)];
        } completion:^(BOOL finished) {
            self.show = YES;
        }];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.titles count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.titles[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.submit setTitle:self.titles[row] forState:UIControlStateNormal];
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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 

@end

*/
