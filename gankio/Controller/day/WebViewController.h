//
//  WebViewController.h
//  gankio
//
//  Created by 武国斌 on 16/9/9.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController

@property (nonatomic, copy) NSString *Url;
@property (nonatomic, copy) NSString *type;

- (void)initWeb;
- (void)initImage;

@end
