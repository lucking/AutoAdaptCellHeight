//
//  ServeDDCell.h
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/7/5.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServeDDCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *readLab;

@end
