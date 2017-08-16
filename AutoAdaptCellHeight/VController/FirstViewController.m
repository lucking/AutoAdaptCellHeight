//
//  FirstViewController.m
//  ZM_UIAlertView
//
//  Created by tangdi on 15/1/13.
//  Copyright (c) 2015年 ZhangM. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "BaseHeader.h"
#import "YYWebImage.h"

@interface FirstViewController ()
{
    BOOL isflage;

}
@property (strong, nonatomic) YYAnimatedImageView *imgView;
@property (retain, nonatomic) NSArray *urlArray;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.view.backgroundColor = White_COLOR;
    [self.Btn1 setTitle:@"读取" forState:UIControlStateNormal];
    [self.Btn2 setTitle:@"归档" forState:UIControlStateNormal];
	
    
    
    //显示GIF动态图用：YYImage
    NSString* name = @"A环游1080.gif";

    float WH = 100;
     _imgView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(20, 80, WH, WH)];
    _imgView.center = CGPointMake(SSWIDTH/2, 100+ WH/2);
    _imgView.backgroundColor = Yellow_COLOR;
    _imgView.image = [YYImage imageNamed:name];
    [self.view addSubview:_imgView];


    
    YYImage *image = [YYImage imageNamed:name];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.frame=  CGRectMake(20, 300, WH, WH);
    imageView.backgroundColor = CyanColor;
    [self.view addSubview:imageView];
    
}

- (NSData *)dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}



//按钮方法
- (IBAction)BtnClick:(UIButton *)Btn{
    if (Btn.tag == 111) {

    }else if(Btn.tag == 222){

    }
}


//触摸时：隐藏导航条
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    isflage=!isflage;
    //    [super touchesMoved:touches withEvent:event];
    [super.navigationController setNavigationBarHidden:isflage animated:TRUE];
    [super.navigationController setToolbarHidden:isflage animated:TRUE];
}

@end
