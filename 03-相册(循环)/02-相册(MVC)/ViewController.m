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
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *images;                  //图片的路径
@property (nonatomic)         NSInteger currentIndex;           //当前显示的缩放的zoomScrollView的索引
@end

@implementation ViewController

//懒加载图片路径
-(NSArray *)images {
    if (_images == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < ImageCount; i++) {
            //图片的名称
            NSString *imageName = [NSString stringWithFormat:@"new_feature_%d@2x",i + 1];
            //图片的路径
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            [array addObject:imagePath];
        }
        _images = array;
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1、创建一个底部滚动的scrollView
    [self createdAndAddScrollView];
    //2、在滚动的scrollView添加缩放的zoomScrollView
    [self addZoomScrollViewForScrollView];
    
    //3、配置缩放scrollView的图片
    [self configurationImageForZoomScrollViews];
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
//在滚动的scrollView添加缩放的zoomScrollView
-(void)addZoomScrollViewForScrollView {
    for (int i = 0; i < 3; i++) {
        QYZoomScrollView *zoomScrollView = [[QYZoomScrollView alloc] initWithFrame:CGRectMake((QYScreenW + 25) * i, 0, QYScreenW, QYScreenH)];
        [_scrollView addSubview:zoomScrollView];
        zoomScrollView.tag = 100 + i;
    }
}


//确保索引合法
-(NSInteger)enableForIndex:(NSInteger)index {
    if (index < 0) {
        return self.images.count - 1;
    }else{
        return index % (self.images.count);
    }
}

//配置缩放scrollView的图片
-(void)configurationImageForZoomScrollViews{
    //1、获取左中右三个缩放的zoomScrollView
    QYZoomScrollView *leftZoomScrollView = [_scrollView viewWithTag:100];
    QYZoomScrollView *middleZoomScrollView = [_scrollView viewWithTag:101];
    QYZoomScrollView *rightZoomScrollView = [_scrollView viewWithTag:102];
    //2、对三个缩放的zoomScrollView设置图片
    NSInteger leftIndex = [self enableForIndex:(_currentIndex - 1)];
    leftZoomScrollView.img = [UIImage imageWithContentsOfFile:self.images[leftIndex]];
    
    NSInteger middleIndex = [self enableForIndex:(_currentIndex)];
    middleZoomScrollView.img = [UIImage imageWithContentsOfFile:self.images[middleIndex]];
    
    NSInteger rightIndex = [self enableForIndex:(_currentIndex + 1)];
    rightZoomScrollView.img = [UIImage imageWithContentsOfFile:self.images[rightIndex]];
    //3、设置底部滚动的scrollView的偏移量（确保屏幕显示的是中间的zoomScrollView）
    [_scrollView setContentOffset:CGPointMake((QYScreenW + 25), 0)];
}


#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[QYZoomScrollView class]]) {
            QYZoomScrollView *zoomScrollView = obj;
            [zoomScrollView setZoomScale:1.0 animated:NO];
        }
    }];
    
    //滚动结束后，重置缩放zoomScrollView的图片，并设置底部滚动的scrollView的偏移量
    if (scrollView.contentOffset.x == 0) {//右滑动
        _currentIndex--;
    }else if (scrollView.contentOffset.x == (QYScreenW + 25) * 2) {//左滑动
        _currentIndex++;
    }
    
    //保证_currentIndex合法
    _currentIndex = [self enableForIndex:_currentIndex];
    
    [self configurationImageForZoomScrollViews];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
