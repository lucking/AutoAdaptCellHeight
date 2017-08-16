//
//  ZMPropertyManager.h
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/2/15.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZMPropertyManager : NSObject
{
    
}
+(instancetype)shareZHPropertyManager;
-(UIFont *)getTitleFont;
-(UIFont *)getContentFont;
-(UIFont *)getTimeFont;

@end
