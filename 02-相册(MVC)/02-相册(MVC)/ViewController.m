//
//  ViewController.m
//  02-相册(MVC)
//
//  Created by qingyun on 16/4/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYZoomScrollView.h"
#define QYScreenW [UIScreen mainScreen].bounds.size.width
#define QYScreenH [UIScreen mainScreen].bounds.size.height
#define ImageCount 6
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1、创建一个底部滚动的scrollView
    [self createdAndAddScrollView];
    //2、在滚动的scrollView添加缩放的zoomScrollView
    [self addZoomScrollViewForScrollView];
    // Do any additional setup after loading the view, typically from a nib.
}
//创建一个底部滚动的scrollView
-(void)createdAndAddScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, QYScreenW + 25, QYScreenH)];
    [self.view addSubview:scrollView];
    
    //设置contentSize
    scrollView.contentSize = CGSizeMake((QYScreenW + 25) * ImageCount, QYScreenH);
    //分页
    scrollView.pagingEnabled = YES;
    //背景颜色
    scrollView.backgroundColor = [UIColor blackColor];
    //隐藏滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    scrollView.delegate = self;
    
    _scrollView = scrollView;
}

-(void)addZoomScrollViewForScrollView {
    for (int i = 0; i < ImageCount; i++) {
        QYZoomScrollView *zoomScrollView = [[QYZoomScrollView alloc] initWithFrame:CGRectMake((QYScreenW + 25) * i, 0, QYScreenW, QYScreenH)];
        [_scrollView addSubview:zoomScrollView];
        //设置图片
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        zoomScrollView.img = [UIImage imageNamed:imageName];
    }
}


#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[QYZoomScrollView class]]) {
            QYZoomScrollView *zoomScrollView = obj;
            [zoomScrollView setZoomScale:1.0 animated:YES];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
