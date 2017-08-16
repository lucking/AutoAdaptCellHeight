//
//  ZMLayoutTableVController.m
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/2/15.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "ZMLayoutTableVController.h"

#import "ZMCellHeightCalculator.h"
#import "ZMCalculateCell.h"

#define CellIdentifier @"ZMCellId"


@interface ZMLayoutTableVController ()
{
    NSArray *dataArray;
    ZMCellHeightCalculator *heightCalculator;
}
@property (nonatomic, strong)  ZMCalculateCell *prototypeCell;
@end

@implementation ZMLayoutTableVController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    heightCalculator = [[ZMCellHeightCalculator alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZMCalculateCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension; //此句可以省略
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self initialData];
    
}


#pragma mark Private Methods
-(void)initialData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *array = [dic objectForKey:@"feed"];
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        ZMCalculateHeightModel *model = [[ZMCalculateHeightModel alloc]initWithDictionary:dic];
        [muArray addObject:model];
    }
    dataArray = [NSArray arrayWithArray:muArray];
    
}

#pragma mark － TableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMCalculateHeightModel *model = model = [dataArray objectAtIndex:indexPath.row];
    
    CGFloat height = [heightCalculator heightForCalculateheightModel:model];
    if (height>0) {
        NSLog(@"cache height");
        return height;
    }else{
        NSLog(@"calculate height");
    }
    ZMCalculateCell *cell = self.prototypeCell;
    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //必须先对Cell中的数据进行配置使动态计算时能够知道根据Cell内容计算出合适的高度
    [self configureCell:cell atIndexPath:indexPath];
    
    /*---------重点这里必须加上contentView的宽度约束，不然计算出来的高度不准确-----------*/
    CGFloat contentViewWidth = CGRectGetWidth(self.tableView.bounds);
    NSLayoutConstraint *widthFenceConstraint
    = [NSLayoutConstraint constraintWithItem:cell.contentView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0
                                    constant:contentViewWidth];
    [cell.contentView addConstraint:widthFenceConstraint];
    // 自动布局引擎做数字计算
    CGFloat fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [cell.contentView removeConstraint:widthFenceConstraint];
    /*-------------------------------End------------------------------------*/
    
    CGFloat cellHeight = fittingHeight+2*1/[UIScreen mainScreen].scale;//必须加上上下分割线的高度
    [heightCalculator setHeight:cellHeight withCalculateheightModel:model];
    return cellHeight;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMCalculateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



#pragma mark - TableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }

    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark Configure Cell Data
- (void)configureCell:(ZMCalculateCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.model = [dataArray objectAtIndex:indexPath.row];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
