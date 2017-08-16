//
//  ServeViewController.m
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/7/5.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "ServeViewController.h"

#import "BaseHeader.h"
#import "ServeAACell.h"
#import "ServeBBCell.h"
#import "ServeCCCell.h"
#import "ServeDDCell.h"
#import "ServeEECell.h"

NSString *const  ServeCellID_AA = @"ServeAACell";
NSString *const  ServeCellID_BB = @"ServeBBCell";
NSString *const  ServeCellID_CC = @"ServeCCCell";
NSString *const  ServeCellID_DD = @"ServeDDCell";
NSString *const  ServeCellID_EE = @"ServeEECell";
static CGFloat rowHeight = 500;// cell的高度


@interface ServeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *ttableView;
@property (nonatomic, strong) UIView *topView;
@end

@implementation ServeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 初始化TableView
    [self setTableView:CGRectMake(0, 0, SSWIDTH,SSHEIGHT) withstyle:0];
    
    [_ttableView registerNib:[UINib nibWithNibName:@"ServeAACell"
                bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServeCellID_AA];
    [_ttableView registerNib:[UINib nibWithNibName:@"ServeBBCell"
                bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServeCellID_BB];
    [_ttableView registerNib:[UINib nibWithNibName:@"ServeCCCell"
                bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServeCellID_CC];
    [_ttableView registerNib:[UINib nibWithNibName:@"ServeDDCell"
                bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServeCellID_DD];
    [_ttableView registerNib:[UINib nibWithNibName:@"ServeEECell"
                bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServeCellID_EE];
    
//    _ttableView.estimatedRowHeight = rowHeight;
//    _ttableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark -------------布局---------
-(UITableView *)setTableView:(CGRect)fame withstyle:(UITableViewStyle )style{
    if (!_ttableView) {
        _ttableView = [[UITableView alloc] initWithFrame:fame style:style];
        _ttableView.dataSource = self;
        _ttableView.delegate = self;
        _ttableView.scrollEnabled = YES;
        [_ttableView setTableFooterView:[UIView new]];
        [self.view addSubview:_ttableView];
    }return _ttableView;
}
#pragma mark ============="  UITableViewDataSource、UITableViewDelegate  "==============

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>6) {
        return 60;
    } else {
        tableView.estimatedRowHeight = rowHeight;
        return  UITableViewAutomaticDimension;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0 || indexPath.row==1) {
        ServeAACell *cell = [tableView dequeueReusableCellWithIdentifier:ServeCellID_AA];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.row==0) {
            cell.titleLab.text = @"Label房价高企的当下，为什么不做好租赁体系？";
        }else{
            cell.titleLab.text = @"为什么不做好租赁体系？";
        }
        return cell;
    }
    else if (indexPath.row==2 || indexPath.row==3 ) {
        ServeBBCell *cell = [tableView dequeueReusableCellWithIdentifier:ServeCellID_BB];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.row==4) {
        ServeCCCell *cell = [tableView dequeueReusableCellWithIdentifier:ServeCellID_CC];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.row==5) {
        ServeDDCell *cell = [tableView dequeueReusableCellWithIdentifier:ServeCellID_DD];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if(indexPath.row==6){
        ServeEECell *cell = [tableView dequeueReusableCellWithIdentifier:ServeCellID_EE];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        static NSString *CellId = @"CellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        }
        cell.textLabel.font = FFont(16.0f);
        cell.textLabel.text = @"你好";
        cell.imageView.image = IMG(@"xyk@2x");
        return cell;
    }
    
//    return nil;
}


//- (UIView *)topView {
//    if (!_topView) {
//        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SSWIDTH, TopView_Height)];
//    }return _topView;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
