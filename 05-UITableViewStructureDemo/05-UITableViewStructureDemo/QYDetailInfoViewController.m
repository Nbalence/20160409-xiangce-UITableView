//
//  QYDetailInfoViewController.m
//  05-UITableViewStructureDemo
//
//  Created by qingyun on 16/4/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYDetailInfoViewController.h"

@interface QYDetailInfoViewController ()

@end

@implementation QYDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _titleString;
    self.view.backgroundColor = [UIColor cyanColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
