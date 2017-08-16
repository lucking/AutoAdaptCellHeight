//
//  ScaleImageConfig.h
//  ImageBigAndStore
//
//  Created by ZM on 2017/4/17.
//  Copyright © 2017年 ZM. All rights reserved.
//

#ifndef ScaleImageConfig_h
#define ScaleImageConfig_h



//主屏幕的bounds、宽度、高度
#define zScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define zScreenHeight ( [[UIScreen mainScreen] bounds].size.height)
#define zScreenBounds [UIScreen mainScreen].bounds              
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define     Clear_COLOR         [UIColor clearColor]    // 透明色


// 图片保存成功提示文字
//#define ZMaveImageSuccessText   @" ^_^ 保存成功 ";
#define ZMaveImageSuccessText   @" 保存成功 ";

// 图片保存失败提示文字
//#define ZMSaveImageFailText     @" >_< 保存失败 ";
#define ZMSaveImageFailText     @" 保存失败 ";




#endif /* ScaleImageConfig_h */
