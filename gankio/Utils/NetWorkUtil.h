//
//  NetWorkUtil.h
//  gankio
//
//  Created by 武国斌 on 16/9/8.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetWorkUtil : NSObject

+ (void)getWithUrl:(NSString *)urlStr andCallBack:(void (^)(NSDictionary *result))block;

@end

@interface NSString (Encrypt)

- (NSString *)urlDecode;
- (NSString *)urlEncode;

@end
