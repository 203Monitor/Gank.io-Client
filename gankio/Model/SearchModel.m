//
//  SearchCell.m
//  gankio
//
//  Created by 武国斌 on 16/9/12.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

+ (SearchModel *)setModel:(NSDictionary *)data {
    SearchModel *model = [[SearchModel alloc] init];
    [model setValuesForKeysWithDictionary:data];
    return model;
}

@end
