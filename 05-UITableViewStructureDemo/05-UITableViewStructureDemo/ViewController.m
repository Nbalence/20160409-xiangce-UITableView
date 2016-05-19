//
//  ViewController.m
//  05-UITableViewStructureDemo
//
//  Created by qingyun on 16/4/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYDetailInfoViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController

-(NSArray *)datas {
    if (_datas == nil) {
        _datas = @[@"zhangsan",@"lisi",@"wangwu",@"zhaoliu",@"tainqi",@"songba"];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建并添加UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    
    //设置代理和数据源
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //设置背景视图
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:tableView.bounds];
    //非png格式的图片必须带后缀名
    bgView.image = [UIImage imageNamed:@"bg.jpg"];
    tableView.backgroundView = bgView;
    //设置tableView的头尾视图
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 100)];
    headerLabel.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:.5 alpha:0.8];
    headerLabel.text = @"TableViewHeaderView";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont boldSystemFontOfSize:24.0];
    tableView.tableHeaderView = headerLabel;
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 100)];
    footerLabel.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:.0 alpha:0.8];
    footerLabel.text = @"TableViewFooterView";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.font = [UIFont boldSystemFontOfSize:24.0];
    tableView.tableFooterView = footerLabel;
    
    //section的头尾高度
    tableView.sectionHeaderHeight = 80;
    tableView.sectionFooterHeight = 80;
    
    //行高
    tableView.rowHeight = 60;
    
    //分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //颜色
    tableView.separatorColor = [UIColor redColor];
    //缩进
    tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 50);
    
    //是否允许多选
    tableView.allowsMultipleSelection = NO;
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//组中行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
    //设置cell内容
    cell.textLabel.text = self.datas[indexPath.row];
    
    return cell;
}

//设置section头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"SectionHeaderView:%ld",section];
}
//设置section尾标题
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"SectionFooterView:%ld",section];
}


#pragma mark  -UITableViewDelegate
//设置某一行的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 2) {
        return 30;
    }
    return 60;
}

//自定义section头尾视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

//自定义section的头尾视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionHeaderLabel = [[UILabel alloc] init];
    sectionHeaderLabel.text = [NSString stringWithFormat:@"SectionHeaderView:%ld",section];
    sectionHeaderLabel.textAlignment = NSTextAlignmentCenter;
    sectionHeaderLabel.font = [UIFont boldSystemFontOfSize:24];
    sectionHeaderLabel.backgroundColor = [UIColor clearColor];
    return sectionHeaderLabel;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *sectionFooterLabel = [[UILabel alloc] init];
    sectionFooterLabel.text = [NSString stringWithFormat:@"SectionFooterView:%ld",section];
    sectionFooterLabel.textAlignment = NSTextAlignmentCenter;
    sectionFooterLabel.font = [UIFont boldSystemFontOfSize:24];
    sectionFooterLabel.backgroundColor = [UIColor clearColor];
    return sectionFooterLabel;
}

//将要选中行
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}


//已经选中行(常用)
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //作用：跳转下一个页面，并且把当前选中的单元格数据，传递过去
    
    //寻找选中的单元格
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    //通过cell获取indexPath
//    NSIndexPath *path = [tableView indexPathForCell:cell];
    
    QYDetailInfoViewController *detailInfoVC = [[QYDetailInfoViewController alloc] init];
    detailInfoVC.titleString = cell.textLabel.text;
    [self.navigationController pushViewController:detailInfoVC animated:YES];
}

//辅助按钮
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellAccessoryDetailDisclosureButton;
}
//点击辅助按钮调用
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
