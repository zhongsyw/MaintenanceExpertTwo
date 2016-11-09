//
//  ZSSettingViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/26.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSSettingViewController.h"
#import "ZSLoginViewController.h"
#import "ZSMineViewController.h"
#import "ZSMineInfoViewController.h"

@interface ZSSettingViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableview;;


@end

@implementation ZSSettingViewController


//- (void)viewWillAppear:(BOOL)animated {
//    
//    NSString *username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
//    self.navigationController.navigationBarHidden = NO;
//    
//    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 24, KScreenWidth, 64) style:UITableViewStylePlain];
//    _tableview.backgroundColor = [UIColor cyanColor];
//    _tableview.delegate = self;
//    _tableview.dataSource = self;
//    
//    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    
//    [self.view addSubview:_tableview];
//    
//    
//    
//    
//    self.view.backgroundColor = [UIColor cyanColor];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, _tableview.frame.size.height + 32, KScreenWidth - 20, 40)];
//    
//    btn.layer.cornerRadius = 10;
//    if (username != nil) {
//        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(outlogin) forControlEvents:UIControlEventTouchDown];
//    }else {
//        [btn setTitle:@"您还未登录" forState:UIControlStateNormal];
//        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                      message:@"您还未登录"
//                                                     delegate:self
//                                            cancelButtonTitle:@"返回"
//                                            otherButtonTitles:nil];
//        [alert show];
//        
//    }
//    
//    btn.tintColor = [UIColor whiteColor];
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    btn.backgroundColor = [UIColor orangeColor];
//    
//    [self.view addSubview:btn];
//
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationController.navigationBarHidden = NO;
    
    NSString *username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(5, 24, KScreenWidth - 10, 64) style:UITableViewStylePlain];
    
    _tableview.backgroundColor = [UIColor cyanColor];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;

    
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
  
    self.view.backgroundColor = [UIColor cyanColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, _tableview.frame.size.height + 32, KScreenWidth - 20, 40)];
    
    btn.layer.cornerRadius = 10;
    if (username != nil) {
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(outlogin) forControlEvents:UIControlEventTouchDown];
    }else {
        [btn setTitle:@"您还未登录" forState:UIControlStateNormal];
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"您还未登录"
                                                     delegate:self
                                            cancelButtonTitle:@"返回"
                                            otherButtonTitles:nil];
        [alert show];
        
    }
    
    btn.tintColor = [UIColor whiteColor];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    btn.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:btn];
    [self.view addSubview:_tableview];

    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"修改资料";
    
    cell.layer.cornerRadius = 5;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
        ZSMineInfoViewController *zsm = [[ZSMineInfoViewController alloc]init];
    
    
        [self.navigationController pushViewController:zsm animated:YES];
    
        [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
   
}



//ALertView即将消失时的事件
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)outlogin {

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [self.navigationController popViewControllerAnimated:YES];
    
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
