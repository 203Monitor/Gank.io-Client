//
//  ItemModel.h
//  gankio
//
//  Created by 武国斌 on 16/9/8.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *publishedAt;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *used;
@property (nonatomic, copy) NSString *who;
@property (nonatomic, copy) NSString *images;

+ (ItemModel *)setModel:(NSDictionary *)data;

@end
