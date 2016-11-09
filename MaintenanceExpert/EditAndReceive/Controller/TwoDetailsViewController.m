//
//  TwoDetailsViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/7.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "TwoDetailsViewController.h"
#import "TwoPayTypeViewController.h"

//#define HEADERIMG_HEIGHT 64

@interface TwoDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>


{
    UIView *headerView;
    UIView *btnBackView;
}


@property (strong, nonatomic) UITableView *tableView;

@end

@implementation TwoDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"订单详情";
    
//    [self creatNavigationView];
    [self creatTableView];
    [self creatPayButton];
}


/*
- (void)creatNavigationView {
    
    //  Navigation 发 布
    headerView = [[UIImageView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
    [self.view addSubview:headerView];
    headerView.sd_layout.leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(HEADERIMG_HEIGHT);
    
    UILabel *titleLable = [[UILabel alloc] init];
    //    titleLable.backgroundColor = [UIColor purpleColor];
    titleLable.text = @"发 布";
    [titleLable setFont:[UIFont systemFontOfSize:18]];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    titleLable.sd_layout.leftSpaceToView(headerView, self.view.frame.size.width / 2 - 30)
    .topSpaceToView(headerView, 25)
    .bottomSpaceToView(headerView, 5)
    .widthIs(60);
    
    //  取消按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 30, 40, 30);
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backBtn];
    
}
*/

- (void)creatTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)creatPayButton {
    
    btnBackView = [[UIView alloc] init];
    btnBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnBackView];
    btnBackView.sd_layout.leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(60);
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(10, 10, KScreenWidth - 20, 40);
    [payBtn setTitle:@"确认订单" forState:UIControlStateNormal];
    [payBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [payBtn addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchDown];
    payBtn.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
    [btnBackView addSubview:payBtn];
}

- (void)payButtonClick {
    
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单已提交，感谢您对我公司的支持，我们会尽快为您服务" delegate:self cancelButtonTitle:@"前往付款" otherButtonTitles:@"取消", nil];
//    
//    [alertView show];
    
    
    NSString *title = @"提示";
    NSString *message = @"订单已提交，感谢您对我公司的支持，我们会尽快为您服务";
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"前往付款", nil);
    
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
//    __weak typeof(alert) wAlert = alert; [alert ...];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消---");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"前往付款---");
        
        TwoPayTypeViewController *payType = [[TwoPayTypeViewController alloc] init];
        
        [self.navigationController pushViewController:payType animated:YES];
        
    }];
    
    // Add the actions.
    [alertContr addAction:cancelAction];
    [alertContr addAction:otherAction];
    
    [self presentViewController:alertContr animated:YES completion:nil];
    
    
    
    NSLog(@"前往--付款");
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"拍照--订单详情";
    
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
