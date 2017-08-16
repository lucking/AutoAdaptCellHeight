//
//  ZMCalculateCell.m
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/2/15.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "ZMCalculateCell.h"

@implementation ZMCalculateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Setters
-(void)setModel:(ZMCalculateHeightModel *)model
{
    _model = model;
    self.TitleLabel.text = model.title;
    self.ContentLabel.text = model.content;
    self.showImgView.image = model.imageName.length > 0 ? [UIImage imageNamed:model.imageName] : nil;
    self.UseNameLabel.text = model.username;
    self.TimeLabel.text = model.time;
    
}



@end
