//
//  QYZoomScrollView.m
//  02-相册(MVC)
//
//  Created by qingyun on 16/4/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYZoomScrollView.h"

@interface QYZoomScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation QYZoomScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加子视图imageView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        _imageView = imageView;
        
        //设置自身属性
        self.minimumZoomScale = 0.5;
        self.maximumZoomScale = 1.5;
        self.delegate = self;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
    }
    return self;
}

//双击
-(void)doubleClick:(UITapGestureRecognizer *)tap {
    //1、如果当前的scrollView的缩放比例不为1.0,需要置为1.0
    if (self.zoomScale != 1.0) {
        [self setZoomScale:1.0 animated:YES];
        return;
    }
    
    //2、如果是1.0 放大
    //矩形区域的中心点
    CGPoint location = [tap locationInView:self];
    CGFloat rectW = 200;
    CGFloat rectH = 100;
    CGRect rect = CGRectMake(location.x - rectW / 2.0, location.y - rectH / 2.0, rectW, rectH);
    [self zoomToRect:rect animated:YES];
}

//重写setImg方法 设置imageView的image
-(void)setImg:(UIImage *)img{
    //自身完成的事情（对属性赋值）
    _img = img;
    
    [_imageView setImage:img];
}

#pragma mark -UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

@end
