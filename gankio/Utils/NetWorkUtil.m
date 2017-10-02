//
//  NetWorkUtil.m
//  gankio
//
//  Created by 武国斌 on 16/9/8.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "NetWorkUtil.h"
#import "AFNetworking.h"

@interface NetWorkUtil ()

@end

@implementation NetWorkUtil

+ (void)getWithUrl:(NSString *)urlStr andCallBack:(void (^)(NSDictionary *result))block {
    
//    NSLog(@"%@",[[urlStr urlEncode] urlDecode]);
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:[urlStr urlEncode] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        downloadProgress.totalUnitCount
//        downloadProgress.completedUnitCount
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}

@end

@implementation NSString (Encrypt)

//- (NSString *)urlDecode {
//    NSMutableString *outputStr = [NSMutableString stringWithString:self];
//    [outputStr replaceOccurrencesOfString:@"+"
//                               withString:@""
//                                  options:NSLiteralSearch
//                                    range:NSMakeRange(0, [outputStr length])];
//    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}

- (NSString *)urlDecode {
    return [self stringByRemovingPercentEncoding];
}

//- (NSString *)urlEncode {
//        return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}


//- (NSString *)urlEncode {
//    NSString* outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, /* allocator */
//                                                                                       (__bridge CFStringRef)self,
//                                                                                       NULL, /* charactersToLeaveUnescaped */
//                                                                                       (CFStringRef)@"!*'();@&=+$,?%#[]",
//                                                                                       kCFStringEncodingUTF8);
//    return outputStr;
//}

- (NSString *)urlEncode {
    NSString *charactersToEscape = @"?!@#$^&%*+,;='\"`<>()[]{}\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

@end
