//
//  ItemCell.h
//  gankio
//
//  Created by 武国斌 on 16/9/8.
//  Copyright © 2016年 武国斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *sender;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
