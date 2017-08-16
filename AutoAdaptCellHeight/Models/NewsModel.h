//
//  NewsModel.h
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/4/19.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
{
    
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *imageName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
