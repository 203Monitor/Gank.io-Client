//
//  Common.h
//  gankio
//
//  Created by 武国斌 on 16/9/12.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define APP [UIApplication sharedApplication]
#define DELEGATE APP.delegate

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define TABBARHEIGHT 49
#define NAVIGATORHEIGHT 64
#define ORIGIN 375.0
#define LAYOUTSCALE(value) value*WIDTH/ORIGIN

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#endif /* Common_h */
