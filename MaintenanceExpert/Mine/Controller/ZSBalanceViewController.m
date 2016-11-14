//
//  ZSBalanceViewController.m
//  MaintenanceExpert
//
//  Created by 中数 on 16/11/14.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceViewController.h"

@interface ZSBalanceViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation ZSBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self creatTableView];
}


- (void)creatTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifer = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    }
    
    if (indexPath.row == 0) {
        
#warning 这里 点击这个Cell是进入 交易记录 页面
        
        cell.textLabel.text = @"账户余额";
        cell.detailTextLabel.text = @"100000.00";
    }else if (indexPath.row == 1) {
        
        cell.textLabel.text = @"充值";
    }else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"提现";
    }
    
    return cell;
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
