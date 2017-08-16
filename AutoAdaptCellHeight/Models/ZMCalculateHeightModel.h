//
//  ZMCalculateHeightModel.h
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/2/15.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCalculateHeightModel : NSObject
{
    
}
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *imageName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
