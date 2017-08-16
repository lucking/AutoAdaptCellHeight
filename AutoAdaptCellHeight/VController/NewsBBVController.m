//
//  NewsBBVController.m
//  AutoAdaptCellHeight
//
//  Created by ZM on 2017/4/19.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "NewsBBVController.h"
#import "RwtCell.h"
#import "SelectModel.h"
#import "BaseHeader.h"
#import "ScaleImageView.h"
#import "YYWebImage.h"
#import "UIView+Frame.h"
#import "NSString+ZMAdd.h"

static NSString *_cellId = @"RwtCell";
static CGFloat rowHeight = 500;// cell的高度

@interface NewsBBVController ()< UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArray;
}
@property (nonatomic, strong) UITableView *ttableView;
@property (nonatomic, strong) RwtCell *prototypeCell;
@property (strong, nonatomic) SelectModel *currentModel;//
@property (strong, nonatomic) NSMutableArray *selectArray;//多选选，当前选中的行

@end

@implementation NewsBBVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NewsBBVC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化TableView
    [self setTableView:CGRectMake(0, 0, SSWIDTH,SSHEIGHT) withstyle:0];
    
    [_ttableView registerNib:[UINib nibWithNibName:@"RwtCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:_cellId];
    _ttableView.estimatedRowHeight = rowHeight;
    _ttableView.rowHeight = UITableViewAutomaticDimension; //此句可以省略
    _ttableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.prototypeCell = [_ttableView dequeueReusableCellWithIdentifier:_cellId];
    
    //模拟请求数据
    [self performSelector:@selector(requestData) withObject:@"" afterDelay:0.5f];

}
//请求获取数据
- (void)requestData {
    
    //数据源
    [self initialData];
    //cell是否读取全文的选择情况
    _currentModel = [[SelectModel alloc] init];
    _selectArray = [[NSMutableArray alloc] init];
    for (int i=0; i< dataArray.count; i++) {
        SelectModel *model = [[SelectModel alloc] init];
        model.isSelect = NO;
        model.index = i;
        [_selectArray addObject:model];
    }
    [_ttableView reloadData];
    //NSLog(@"---> _selectArray= %@", _selectArray);
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RwtCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellId];
    //配置数据
    cell.model = [dataArray objectAtIndex:indexPath.row];
    
    //方式
    _currentModel = _selectArray[indexPath.row];
    
    NSLog(@"--> isSelect = %d",_currentModel.isSelect);
    if (indexPath.row == (dataArray.count-1)) {
        NSLog(@"--> \n \n ");
    }
    if (_currentModel.isSelect) {
        [cell.readBtn setTitle:@"收起" forState:UIControlStateNormal];
        [cell.readBtn setTitleColor:Blue_2599FA forState:UIControlStateNormal];
        cell.content.numberOfLines = 0; //down.png、up.png
    }else{
        [cell.readBtn setTitle:@"全文" forState:UIControlStateNormal];
        [cell.readBtn setTitleColor:Gray_666666 forState:UIControlStateNormal];
        cell.content.numberOfLines = 1;
    }
    cell.readBtn.tag = indexPath.row;
    [cell.readBtn addTarget:self action:@selector(readBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.readBtn.backgroundColor = [UIColor clearColor];

    // 图片：添加单击手势
    cell.imgView.tag = indexPath.row;
    cell.imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upLoadBtnClick:)];
    [cell.imgView addGestureRecognizer:tap];
    
    return cell;
}

//点击图片，放大缩小
- (void)upLoadBtnClick:(UITapGestureRecognizer *)recognizer {
    
    //NSLog(@"--> recognizer.view = %@",recognizer.view);
    //NSInteger currentIndex = currentImgView.tag;
    //NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    
    UIImageView *currentImgView = (UIImageView *)recognizer.view;
    NSLog(@"--> showImgView.tag = %ld",(long)currentImgView.tag);
    RwtCell *cell= (RwtCell *)currentImgView.superview.superview.superview;//3层 cell.Bgview -->cell.contentView -->cell

    //先计算cell.Bgview的位置,再转化到self.view中的位置.
    CGRect imgViewFrame = [cell.Bgview convertRect:cell.imgView.frame toView:self.view];
    NSLog(@"--> imgViewFrame_X = %f",imgViewFrame.origin.x);
    NSLog(@"--> imgViewFrame_Y = %f",imgViewFrame.origin.y);
    NSLog(@"--> imgViewFrame_W = %f",imgViewFrame.size.width);
    NSLog(@"--> imgViewFrame_H = %f",imgViewFrame.size.height);
    NSLog(@"--> imageFrame_W = %f",cell.imgView.image.size.width);
    NSLog(@"--> imageFrame_H = %f \n ",cell.imgView.image.size.height);
    
    
    /******************  如果图片约束设置了 AspectFit 则作如下处理，否则，不需要一下代码  *********************/

    //根据约束的情况处理图片在屏幕中的位置：高度固定为60px，宽度自适应，图片居中，处理x起点，则图片尺寸如下
    CGFloat fixHeight = 80;
    CGFloat AspectFitWidth = (cell.imgView.image.size.width/cell.imgView.image.size.height)* fixHeight;
    CGFloat xx= imgViewFrame.origin.x + (cell.imgView.frame.size.width/2-AspectFitWidth/2);
    imgViewFrame = CGRectMake(xx,imgViewFrame.origin.y,
                               AspectFitWidth,
                               fixHeight);
    
    NSLog(@"--> imgViewFrame_X = %f",imgViewFrame.origin.x);
    NSLog(@"--> imgViewFrame_Y = %f",imgViewFrame.origin.y);
    NSLog(@"--> imageFrame_W = %f",imgViewFrame.size.width);
    NSLog(@"--> imageFrame_H = %f \n \n ",imgViewFrame.size.height);

    /********************************************************************************************/
    
    //图片放大
    ScaleImageView * _scaleImgView;
    _scaleImgView = [[ScaleImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _scaleImgView.showType = ScaleGingleTapDismiss;
    _scaleImgView.imageViewFram = imgViewFrame;
    _scaleImgView.image = cell.imgView.image;
    [[UIApplication sharedApplication].keyWindow addSubview:_scaleImgView];
}

//收起、全文
- (void)readBtnClick:(UIButton *)Btn {
//    NSLog(@"---> indexPath= %ld",(long)Btn.tag);
    SelectModel *model = [[SelectModel alloc] init];

    //  获取Btn所在的cell、通过调用superview来获取父视图
    // RwtCell *cell= (RwtCell *)Btn.superview.superview.superview;//3层
    NSInteger currentIndex = Btn.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    model = _selectArray[indexPath.row];
   
//    CGFloat hh = [NSString getTextSizeHeight:cell.content.text Font:cell.content.font Width:cell.content.width];
//    NSLog(@"--> hh = %f",hh);
    NSLog(@"--> isSelect = %d",model.isSelect);
    if (model.isSelect) {
        model.isSelect = NO;
        NSLog(@"-----> 关闭 \n ");
    }else{
        NSLog(@"-----> 展开 \n ");
        model.isSelect = YES;
    }
    [_selectArray replaceObjectAtIndex:indexPath.row withObject:model];
    [_ttableView reloadData];

}

// didSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"---> row = %ld",(long)indexPath.row);
}

-(UITableView *)setTableView:(CGRect)fame withstyle:(UITableViewStyle )allstyle{
    if (!_ttableView) {
        //_ttableView = [[UITableView alloc] initWithFrame:fame];
        _ttableView = [[UITableView alloc] initWithFrame:fame style:allstyle];
        _ttableView.backgroundColor = [UIColor clearColor];
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
