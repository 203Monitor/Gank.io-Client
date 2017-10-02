//
//  ItemModel.m
//  gankio
//
//  Created by 武国斌 on 16/9/8.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

+ (ItemModel *)setModel:(NSDictionary *)data {
    ItemModel *model = [[ItemModel alloc] init];
    NSLog(@"%@",data);
    [model setValuesForKeysWithDictionary:data];
    return model;
}

@end
