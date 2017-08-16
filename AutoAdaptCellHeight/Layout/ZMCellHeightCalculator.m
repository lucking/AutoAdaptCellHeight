//
//  ZMCellHeightCalculator.m
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/2/15.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "ZMCellHeightCalculator.h"


@interface ZMCellHeightCalculator ()
{
}
@property (strong, nonatomic, readonly) NSCache *cache;
@end



@implementation ZMCellHeightCalculator

#pragma mark - Init
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultConfigure];
    }
    return self;
}

-(void)defaultConfigure
{
    NSCache *cache = [NSCache new];
    cache.name = @"ZMCellHeightCalculator.cache";
    cache.countLimit = 700;
    _cache = cache;
    
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: cache=%@",
            [self class],
            self.cache];
}

#pragma mark - Publci Methods
-(void)clearCaches
{
    [self.cache removeAllObjects];
}


-(void)setHeight:(CGFloat)height withCalculateheightModel:(ZMCalculateHeightModel *)model
{
    NSAssert(model != nil, @"Cell Model can't  nil");
    NSAssert(height >= 0, @"cell height must greater than or equal to 0");
    
    NSLog(@"---> height = %f", height);
    [self.cache setObject:[NSNumber numberWithFloat:height] forKey:@(model.hash)];
}


-(CGFloat)heightForCalculateheightModel:(ZMCalculateHeightModel *)model
{
    NSNumber *cellHeightNumber = [self.cache objectForKey:@(model.hash)];
    if (cellHeightNumber) {
        return [cellHeightNumber floatValue];
    }else
        return -1;
    
}
@end
