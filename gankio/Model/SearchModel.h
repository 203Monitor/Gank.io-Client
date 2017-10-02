//
//  SearchCell.h
//  gankio
//
//  Created by 武国斌 on 16/9/12.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic, copy) NSString *ganhuo_id;
@property (nonatomic, copy) NSString *who;
@property (nonatomic, copy) NSString *readability;
@property (nonatomic, copy) NSString *publishedAt;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *url;

+ (SearchModel *)setModel:(NSDictionary *)data;

@end
