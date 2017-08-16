//
//  ScaleImageView.h
//  ImageBigAndStore
//
//  Created by ZM on 2017/4/17.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

// 展示模式
typedef NS_ENUM(NSInteger,ScaleShowType) {
    
    ScaleGingleTapDismiss = 111,        //
    ScaleGingleTapScaleOrigin = 222,    //
};


@interface ScaleImageView : UIView
{
    
}
/** imgUrl  图像地址*/
@property (nonatomic, copy) NSString *imgUrl;
//图片
@property (nonatomic, strong) UIImage *image;
//图片原位置
@property (nonatomic, assign) CGRect imageViewFram;

@property (nonatomic, copy) void (^RemoveView)();
@property (nonatomic, assign) ScaleShowType showType;

@end
