//
//  ScaleImageView.m
//  ImageBigAndStore
//
//  Created by ZM on 2017/4/17.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "ScaleImageView.h"
#import "UIView+Frame.h"
//#import "SDWebImageManager.h"
//#import "UIImageView+WebCache.h"
#import "YYWebImage.h"
#import "ScaleImageConfig.h"


static CGFloat const animationDutation = 0.05f;
@interface ScaleImageView()<UIScrollViewDelegate>
{
    UIActivityIndicatorView *_indicatorView;
//    UIButton *_saveButton;
    CGFloat selfWidth, selfHeight;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *saveButton;
//和scrollview一般大的   缩放用的
@property (nonatomic, strong) UIView *scaleView;
//@property (nonatomic, strong) UIImageView *zoomImgView;
@property (nonatomic, strong) YYAnimatedImageView *zoomImgView;
@end

@implementation ScaleImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect selfFrame = CGRectMake(0, 0, zScreenWidth, zScreenHeight);
    self = [super initWithFrame:selfFrame];
    //self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        selfWidth = self.frame.size.width;
        selfHeight = self.frame.size.height;

        [self initSubViews];
    }
    return self;
}

#pragma mark - UIScrollView  delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.scaleView;
}

#pragma mark - private method
- (void)initSubViews{
    
    [self.scrollView addSubview:self.scaleView];
    [self.scaleView addSubview:self.zoomImgView];

    //    _scrollView.backgroundColor = PinkDD_COLOR;
    //    _scaleView.backgr jgoundColor = PinkDD_COLOR;
    //    _zoomImgView.backgroundColor = PinkDD_COLOR;
}
/**
 *  移除
 */
- (void)removeView{
    
    if (self.showType == ScaleGingleTapDismiss) {
        
        __weak typeof(self) WS = self;
        [UIView animateWithDuration:0.35f animations:^{
            
            float scaleX = self.scrollView.zoomScale;
            //NSLog(@"--> scaleX = %f",scaleX);
            if (scaleX>1) {
                [self.scrollView setZoomScale:1.0f animated:YES];
            }
            WS.backgroundColor = Clear_COLOR;
            WS.zoomImgView.frame = WS.imageViewFram;

            _saveButton.hidden = YES;
        }completion:^(BOOL finished) {
            [self removeAllSubview];
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self removeFromSuperview];
        }];
    }else{
        [UIView animateWithDuration:animationDutation animations:^{
            [self.scrollView setZoomScale:1.0f animated:YES];
        }completion:^(BOOL finished) {
        }];
    }
}

/**
 *  放大到最大
 */
-(void)doubleTap
{
    float scaleX = self.scrollView.zoomScale;
    NSLog(@"--> scaleX = %f",scaleX);
    if (scaleX>1) {
        
        [UIView animateWithDuration:animationDutation animations:^{
            [self.scrollView setZoomScale:1.0f animated:YES];
        }completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:animationDutation animations:^{
            [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
        }];
    }
}
/**
 *  计算图片尺寸
 */
- (void)calculateImageFrame:(UIImage *)image
{
    self.zoomImgView.image = image;

    CGFloat imgWidth  = image.size.width;
    CGFloat imgHeight = image.size.height;
    CGFloat scrolWidth  = self.scrollView.width;
    CGFloat scrolHeight = self.scrollView.height;
    CGFloat xx, yy, ww, hh;
    xx= 20;
    yy= 20;
    NSLog(@"--> scrolWidth= %f",scrolWidth );
    NSLog(@"--> imgWidth = %f",imgWidth );
    NSLog(@"--> imgHeight= %f",imgHeight );
    if ([self isNotBlank:self.imgUrl]) {
        
    }
    //适配图片尺寸
    //万一没有尺寸
    if (imgWidth==0 || imgHeight==0) {
        xx= 10, yy= 100;
        ww= zScreenWidth-xx*2;
        hh= ww;
        NSLog(@"--> 万一没有尺寸");
    }else{
        //图片的宽高都小于屏幕
        if ( (imgWidth<scrolWidth) && (imgHeight<scrolHeight) ) {
//            ww = zScreenWidth-xx*2;
//            hh = ww;
            NSLog(@"--> 图片的宽高都小于屏幕");
            //默认为自身尺寸
            ww = imgWidth;
            hh = imgHeight;
            //图片很小的情况：适当放大初始图片
            //图片的宽高的2倍都小于屏幕
            int scale = 1;
            if (((2*imgWidth)<scrolWidth) && ((2*imgHeight)<scrolHeight)) {
                ww = 2*imgWidth;
                hh = 2*imgHeight;
                scale= 2;
                NSLog(@"--> 图片的宽高的2倍都小于屏幕");
            }
            //图片的宽高的1.5倍都小于屏幕
            if (((1.5*imgWidth)<scrolWidth) && ((1.5*imgHeight)<scrolHeight) && (scale!=2)) {
                ww = 1.5*imgWidth;
                hh = 1.5*imgHeight;
                NSLog(@"--> 图片的宽高的1.5倍都小于屏幕");
            }            
        }else{
            //图片的宽：大于屏幕
            if (imgWidth > scrolWidth) {
                ww = zScreenWidth-xx*2;
                hh = ww* (imgHeight/imgWidth);
                NSLog(@"--> 图片的宽：大于屏幕");
            }
            //图片的高：大于屏幕
            else{
                hh = zScreenHeight-yy*2;
                ww = hh* (imgWidth/imgHeight);
                NSLog(@"--> 图片的高：大于屏幕");
            }
        }
    }
    self.zoomImgView.frame = CGRectMake(xx, yy, ww, hh);
    self.zoomImgView.center = self.scaleView.center;

}

#pragma mark 普通动画
- (void)flipView:(UIView *)myView Rect:(CGRect)myRect forView:(UIView *)view timeInterval:(NSTimeInterval)myTime isRemove:(BOOL)isRemove
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:myTime];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:view cache:YES];
    //改变尺寸
    myView.frame = myRect;
    if (isRemove) {
        self.alpha = 0.0;
        self.zoomImgView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        //延时执行
        [self performSelector:@selector(delayToRemove) withObject:nil afterDelay:0.5];
    }else{
        //背景变黑
        //self.backgroundColor = [UIColor colorWithWhite:0.098 alpha:1.000];
        self.backgroundColor = [UIColor clearColor];
    }
    
    [UIView commitAnimations];
}
- (void)delayToRemove
{
    // 添加通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"delayToRemove" object:nil];
    //移除
    [self.scaleView removeFromSuperview];
    [self.scrollView removeFromSuperview];
    [self removeFromSuperview];
}


#pragma mark ============================"  setter and getter  "==============================

- (void)setImgUrl:(NSString *)imgUrl{
    
    WS(weakself);
    [self addSubview:self.scrollView];
    
    _imgUrl = imgUrl;
    if (imgUrl) {
        [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:imgUrl] options:YYWebImageOptionProgressive progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            
            weakself.image = image;
            [weakself calculateImageFrame:image];
        }];
    }else{
        [self calculateImageFrame:self.image];
    }
}

- (void)setImage:(UIImage *)image {
    
    WS(weakself);
    [self addSubview:self.scrollView];
    [self saveButton];

    _image = image;
    if (image) {
        [self calculateImageFrame:image];
    }else{
        
        [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:_imgUrl] options:YYWebImageOptionProgressive progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            
            weakself.image = image;
            [weakself calculateImageFrame:image];
        }];

    }
}

#pragma mark ======================"  setUI  "==============================

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bouncesZoom = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = YES;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.frame = CGRectMake(0, 0, zScreenWidth, zScreenHeight);
        //_scrollView.frame = self.bounds;
        //_scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}
- (YYAnimatedImageView *)zoomImgView{
    if (_zoomImgView == nil) {
        _zoomImgView = [[YYAnimatedImageView alloc] init];
        _zoomImgView.clipsToBounds = YES;
        _zoomImgView.backgroundColor = [UIColor clearColor];//yellowColor
        //_zoomImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _zoomImgView;
}

- (UIView *)scaleView{
    if (_scaleView == nil) {
        _scaleView = [[UIView alloc] init];
        _scaleView.frame = _scrollView.frame;
        
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
        [singleTapGestureRecognizer setNumberOfTapsRequired:1];
        [self addGestureRecognizer:singleTapGestureRecognizer];
        
        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
        [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
        [_scaleView addGestureRecognizer:doubleTapGestureRecognizer];
        
        //这行很关键，意思是只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效 （因为有时快速地连续点）
        [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
        _scaleView.backgroundColor = [UIColor clearColor];
    }
    return _scaleView;
}

#pragma mark 保存按钮
- (UIButton *)saveButton {
    if (_saveButton==nil) {
        UIButton *saveButton = [[UIButton alloc] init];
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
        saveButton.layer.cornerRadius = 5;
        saveButton.clipsToBounds = YES;
        [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:saveButton];
        _saveButton = saveButton;
        _saveButton.frame = CGRectMake(selfWidth-70, selfHeight-50, 50, 25);
    }
    return _saveButton;
}

//保存图片
- (void)saveImage
{
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    indicator.center = self.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
}

//保存结果
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.80f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 30);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = ZMSaveImageFailText;
    }   else {
        label.text = ZMaveImageSuccessText;
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (BOOL)isNotBlank:(NSString *)myStr {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < myStr.length; ++i) {
        unichar c = [myStr characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

@end

