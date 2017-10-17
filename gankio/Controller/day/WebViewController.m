//
//  WebViewController.m
//  gankio
//
//  Created by 武国斌 on 16/9/9.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "WebViewController.h"
#import "Common.h"
#import "NetWorkUtil.h"
#import "UIImageView+WebCache.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.type isEqualToString:@"福利"] ? [self initImage] : [self initWeb];
}

- (void)initWeb {
    UIWebView *wv = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    wv.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    NSURL *url = [NSURL URLWithString:self.Url];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [wv loadRequest:request];//加载
    [wv setDelegate:self];
    [self.view addSubview:wv];
}

- (void)initImage {
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [iv sd_setImageWithURL:[NSURL URLWithString:self.Url] placeholderImage:nil options:(SDWebImageRetryFailed) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = iv.image;
        [self.view addSubview:iv];
    }];
    [iv setContentMode:UIViewContentModeScaleAspectFit];
    [iv setUserInteractionEnabled:YES];
    UILongPressGestureRecognizer *gr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(save)];
    gr.minimumPressDuration = 1.0;
    [iv addGestureRecognizer:gr];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSLog(@"%@", webView.request.description);
}

- (void)save {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否保存这个妹子" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //somthing wrong
        UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
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
