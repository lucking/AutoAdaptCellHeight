//
//  RwtCell.m
//  AutoHeightTest
//
//  Created by ZM on 2017/4/19.
//  Copyright © 2017年 yitong. All rights reserved.
//

#import "RwtCell.h"
#import "YYWebImage.h"

@implementation RwtCell


- (void)setModel:(NewsModel *)model {
    _model = model;
    self.date.text = model.time;
    self.title.text = model.title;
    //self.imgView.image = [UIImage imageNamed:@"商品收藏"];
    //self.imgView.image = model.imageName.length > 0 ? [UIImage imageNamed:model.imageName] : nil;
    self.contentTime.text = model.username;
    self.content.text = model.content;


    //YYWebImage YYAnimatedImageView
    if (model.imageName.length > 0) {
        if ([model.imageName hasPrefix:@"http"] || [model.imageName hasPrefix:@"https"]) {
            //网络图
            [self.imgView yy_setImageWithURL:[NSURL URLWithString:model.imageName]
                                     options:YYWebImageOptionProgressive];
        }
        else if ([model.imageName hasSuffix:@"gif"] || [model.imageName hasPrefix:@"GIF"]) {
            //动态图
            self.imgView.image = [YYImage imageNamed:model.imageName];
            //self.imgView.image = [YYImage imageNamed:@"A环游1080"];
        }
        else{
            //静态图
            NSLog(@"--> imageName = %@", model.imageName);
            self.imgView.image = [UIImage imageNamed:model.imageName];
        }
        self.imgHeight.constant = 80;
    }else{
        self.imgHeight.constant = 0;
    }
}


//- (IBAction)readClick:(UIButton *)sender {
//    
////    sender.selected = !sender.selected;
////    self.content.numberOfLines = sender.selected?0:1;
////    !self.expandBlock?:self.expandBlock();
//
//    self.readBtn.selected = !self.readBtn.selected;
//    NSLog(@"---> sender.selected = %d", self.readBtn.selected);
//    if (self.readBtn.selected) {
//        self.content.numberOfLines = 0;
//    }else{
//        self.content.numberOfLines = 1;
//    }
//    if (self.expandBlock) {
//        self.expandBlock();
//    }
//
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
