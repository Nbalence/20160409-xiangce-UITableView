//
//  ViewController.m
//  01-相册
//
//  Created by qingyun on 16/4/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
//底部滚动的scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//小的缩放的scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *firstScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *secondScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *thirdScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置底部滚动的scrollView的contentSize
    _scrollView.contentSize = CGSizeMake(400 * 3, 667);
    //分页
    _scrollView.pagingEnabled = YES;
    
    //隐藏水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

//双击
- (IBAction)doubleClick:(UITapGestureRecognizer *)sender {
    UIScrollView *zoomScrollView = (UIScrollView *)sender.view.superview;
    //1、如果当前的scrollView的缩放比例不为1.0,需要置为1.0
    if (zoomScrollView.zoomScale != 1.0) {
        [zoomScrollView setZoomScale:1.0 animated:YES];
        return;
    }
    
    //2、如果是1.0 放大
    //矩形区域的中心点
    CGPoint location = [sender locationInView:sender.view];
    CGFloat rectW = 200;
    CGFloat rectH = 100;
    CGRect rect = CGRectMake(location.x - rectW / 2.0, location.y - rectH / 2.0, rectW, rectH);
    [zoomScrollView zoomToRect:rect animated:YES];
}

#pragma mark -UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    UIImageView *imageView = [scrollView viewWithTag:100];
    return imageView;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //确定处理的scrollView是dibu滚动的scrollView
    if (scrollView == _scrollView) {
        [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIScrollView class]]) {
                UIScrollView *subScrollView = obj;
                [subScrollView setZoomScale:1.0 animated:YES];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
