//
//  ServeBBCell.h
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/7/5.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServeBBCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewA;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewB;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewC;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *readLab;

@end
