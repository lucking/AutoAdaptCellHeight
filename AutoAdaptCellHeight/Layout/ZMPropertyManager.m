
//
//  ZMPropertyManager.m
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/2/15.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "ZMPropertyManager.h"

@implementation ZMPropertyManager

+(instancetype)shareZHPropertyManager
{
    static ZMPropertyManager *propertyManager = nil;
    static dispatch_once_t *oncePredicate;
    dispatch_once(oncePredicate, ^{
        propertyManager = [[ZMPropertyManager alloc]init];
    });
    return propertyManager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(UIFont *)getTitleFont
{
    return [UIFont boldSystemFontOfSize:18.0];
}

-(UIFont *)getContentFont
{
    return [UIFont systemFontOfSize:14.0];
}

-(UIFont *)getTimeFont
{
    return [UIFont systemFontOfSize:13.0];
}


@end
