//
//  RwtCell.h
//  AutoHeightTest
//
//  Created by ZM on 2017/4/19.
//  Copyright © 2017年 yitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "CALayer+ZM.h"
#import "YYWebImage.h"

@interface RwtCell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UIView *Bgview;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *contentTime;
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;
//阅读按钮
@property (nonatomic, strong) NewsModel *model;
@property (nonatomic, copy) void(^expandBlock)();


//- (IBAction)readClick:(id)sender;

@end
