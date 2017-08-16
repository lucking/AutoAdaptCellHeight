//
//  ZMCellHeightCalculator.h
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/2/15.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZMCalculateHeightModel.h"

@interface ZMCellHeightCalculator : NSObject
{
    
}
//系统计算高度后缓存进cache
-(void)setHeight:(CGFloat)height withCalculateheightModel:(ZMCalculateHeightModel *)model;

//根据model hash 获取cache中的高度,如过无则返回－1
-(CGFloat)heightForCalculateheightModel:(ZMCalculateHeightModel *)model;

//清空cache
-(void)clearCaches;


@end
