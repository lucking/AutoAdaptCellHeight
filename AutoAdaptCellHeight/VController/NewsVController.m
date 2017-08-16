//
//  NewsVController.m
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/4/19.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "NewsVController.h"
#import "RwtCell.h"
//#import "Header.h"
//#import "MessageBoxRootDO.h"
#import "NewsModel.h"


// 全屏宽度、高度
#define SSWIDTH     ([UIScreen mainScreen].bounds.size.width)
#define SSHEIGHT    ([UIScreen mainScreen].bounds.size.height)
static NSString *_cellId = @"RwtCell";
static CGFloat rowHeight = 500;// cell的高度


@interface NewsVController ()< UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArray;
}
@property (nonatomic, strong) UITableView *ttableView;
@property (nonatomic, strong) RwtCell *prototypeCell;
@property (nonatomic, strong) NewsModel *rootDO;
@end

@implementation NewsVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"NewsVC";

    // 初始化TableView
    rowHeight = 90;
    [self setTableView:CGRectMake(0, 0, SSWIDTH,SSHEIGHT) withstyle:UITableViewStylePlain];
    
    //    heightCalculator = [[ZMCellHeightCalculator alloc]init];
    [_ttableView registerNib:[UINib nibWithNibName:@"RwtCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:_cellId];
    _ttableView.estimatedRowHeight = rowHeight;
    _ttableView.rowHeight = UITableViewAutomaticDimension; //此句可以省略
    _ttableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.prototypeCell = [_ttableView dequeueReusableCellWithIdentifier:_cellId];
    
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
        NewsModel *model = [[NewsModel alloc]initWithDictionary:dic];
        [muArray addObject:model];
    }
    dataArray = [NSArray arrayWithArray:muArray];
    [_ttableView reloadData];
    
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

// RowHeight
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RwtCell *cell = self.prototypeCell;
    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    cell.backgroundColor = [UIColor yellowColor];
    //必须先对Cell中的数据进行配置使动态计算时能够知道根据Cell内容计算出合适的高度
    cell.model = [dataArray objectAtIndex:indexPath.row];
    //计算高度
    CGFloat cellHeight = [self tableView:_ttableView tableViewCell:cell];
    NSLog(@"---> cellHeight = %f",cellHeight );
    return cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RwtCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellId];
    cell.model = [dataArray objectAtIndex:indexPath.row];
    
    cell.expandBlock = ^{
        [tableView reloadData];
    };
    return cell;
}

// didSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"---> row = %ld",(long)indexPath.row);
}


//计算高度
- (CGFloat)tableView:(UITableView *)tableView tableViewCell:(UITableViewCell *)cell {
    
    /*---------重点这里必须加上contentView的宽度约束，不然计算出来的高度不准确-----------*/
    CGFloat contentViewWidth = CGRectGetWidth(tableView.bounds);
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
    
    return cellHeight;
}

-(UITableView *)setTableView:(CGRect)fame withstyle:(UITableViewStyle )allstyle{
    if (!_ttableView) {
        _ttableView = [[UITableView alloc] initWithFrame:fame];
        _ttableView.backgroundColor = [UIColor whiteColor];
        _ttableView.dataSource = self;
        _ttableView.delegate = self;
        _ttableView.scrollEnabled = YES;
        [self clearTableViewLine:_ttableView];
        [self.view addSubview:_ttableView];
    }
    return _ttableView;
}
// 清除UITableView底部多余的分割线
- (void)clearTableViewLine:(UITableView *)tabelView{
    
    UIView *View=[UIView new];
    View.backgroundColor= [UIColor clearColor];
    [tabelView setTableHeaderView:View];
    [tabelView setTableFooterView:View];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
