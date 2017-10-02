//
//  Api.h
//  gankio
//
//  Created by 武国斌 on 16/9/8.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#ifndef Api_h
#define Api_h

#define API_HISTORY @"http://gank.io/api/day/history"
#define API_ONEDAY @"http://gank.io/api/day/" 
#define API_SEARCH @"http://gank.io/api/search/query"
#define SEARCH(queryString,category,page) [NSString stringWithFormat:@"%@/%@/category/%@/count/20/page/%i",API_SEARCH,queryString,category,page]

#endif /* Api_h */
