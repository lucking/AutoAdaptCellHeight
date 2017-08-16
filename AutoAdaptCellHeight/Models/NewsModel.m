//
//  NewsModel.m
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/4/19.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _username = dictionary[@"username"];
        _time = dictionary[@"time"];
        _imageName = dictionary[@"imageName"];
        
    }
    return self;
}

@end
