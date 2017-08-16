//
//  ZMCalculateCell.h
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/2/15.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMCalculateHeightModel.h"

@interface ZMCalculateCell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ContentLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *showImgView;
@property (weak, nonatomic) IBOutlet UIImageView *showImgView;
@property (weak, nonatomic) IBOutlet UILabel *UseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (strong, nonatomic) ZMCalculateHeightModel *model;

@end
