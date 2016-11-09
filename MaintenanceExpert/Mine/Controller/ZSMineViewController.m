//
//  ZSMineViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMineViewController.h"
#import "ZSLoginViewController.h"
#import "XLWaveView.h"
#import "UIView+ZSExtension.h"
#import "ZSSettingViewController.h"

#define XLColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ZSMineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 数据数组 */
@property (nonatomic, strong) NSArray *dataList;

/** 记录清空缓存的index */
@property (nonatomic, strong) NSIndexPath *path;

/** 头View */
@property (nonatomic, weak) XLWaveView *waveView;

/** 是否正在播放动画 */
@property (nonatomic, assign, getter=isShowWave) BOOL showWave;


@property (nonatomic,strong)UIButton *loginbtn;
@property (nonatomic,strong)UILabel *shareLabel;

@end

@implementation ZSMineViewController


- (NSArray *)dataList{
    if (!_dataList) {
        NSMutableDictionary *dengji = [NSMutableDictionary dictionary];
        dengji[@"title"] = nil;
        dengji[@"icon"] = nil;
        
        NSMutableDictionary *dingdan = [NSMutableDictionary dictionary];
        dingdan[@"title"] = @"我的订单";
        dingdan[@"icon"] = @"share_platform_qqfriends";
        
        //要跳转到的控制器
        //dingdan[@"controller"] = [ZSLoginViewController class];
        
        NSMutableDictionary *yue = [NSMutableDictionary dictionary];
        yue[@"title"] = @"我的余额";
        yue[@"icon"] = @"share_platform_qqfriends";
        //自己写要跳转到的控制器
        //yue[@"controller"] = [ZSLoginViewController class];
        
        NSMutableDictionary *zsfamily = [NSMutableDictionary dictionary];
        zsfamily[@"title"] = @"中数Family";
        zsfamily[@"icon"] = @"share_platform_qqfriends";
        //zsfamily[@"controller"] = [ZSLoginViewController class];
        
        NSMutableDictionary *help = [NSMutableDictionary dictionary];
        help[@"title"] = @"帮助与反馈";
        help[@"icon"] = @"share_platform_qqfriends";
        //help[@"controller"] = [ZSLoginViewController class];
        
        NSMutableDictionary *cleanCache = [NSMutableDictionary dictionary];
        cleanCache[@"title"] = @"清空缓存";
        cleanCache[@"icon"] = @"share_platform_qqfriends";
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"title"] = @"设置";
        setting[@"icon"] = @"share_platform_qqfriends";
        setting[@"controller"] = [ZSSettingViewController class];
        NSArray *section0 = @[dengji];
        NSArray *section1 = @[dingdan, yue];
        NSArray *section2 = @[zsfamily, help];
        NSArray *section3 = @[cleanCache];
        NSArray *section4 = @[setting];
        
        _dataList = [NSArray arrayWithObjects:section0,section1, section2, section3,section4, nil];
    }
    return _dataList;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
        _tableView.y = -20;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//刷新tableview
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    


    self.navigationController.navigationBarHidden = YES;
    [self setupHeaderView];
    
    
    [self.tableView reloadData];
}


#pragma mark - life cycle...

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)loginBtnAndlab {
    
    self.loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth / 11, 55, 100, 40)];
    
    [self.view addSubview: self.loginbtn];
    
    [self.loginbtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    
   // self.loginbtn.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview: self.loginbtn];

    
    self.shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 80, 80, 50)];
    self.shareLabel.text = nil;
    self.shareLabel.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:self.shareLabel];
    
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(share:)];
    self.shareLabel.userInteractionEnabled = YES;
    [self.shareLabel addGestureRecognizer:taps];

   
}

/**
 *
 *  @param taps 个人界面的 分享按钮
 */
- (void)share:(UITapGestureRecognizer *)taps {
    NSLog(@"去炫耀");
    
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
}


- (void)setupHeaderView
{
    
    NSString *username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSLog(@"username%@",username);

    /**
     *  登录完成之后数据显示
     */
    if (username != nil)
    {
    XLWaveView *wave = [[XLWaveView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 270) Image:@"93S58PICcXy_1024.jpg" centerIcon:@"share_platform_qqfriends"];

    wave.nameLabel.text = @"王欣誉";

    wave.beizannum.text = @"18";

    wave.guanzhunum.text = @"20";

    wave.fensinum.text = @"2";
   
    wave.moneyLabel.text = @"在中数赚了1830.00元";
    
    self.waveView = wave;
    
    [self scrollViewDidScroll:self.tableView];
        
    [self.tableView addSubview:wave];

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth , wave.height)];
    
    self.loginbtn.hidden = YES;
        
    self.shareLabel.hidden = NO;
        
    }else{
    
        /**
         登录界面的页面参数
         
         */
    XLWaveView *wave = [[XLWaveView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 270) Image:@"93S58PICcXy_1024.jpg" centerIcon:@"share_platform_qqfriends"];
    wave.nameLabel.text = @"登录/注册";
    wave.moneyLabel.text = @"";
    // wave.icon.image = [UIImage imageNamed:icon];//头像
    wave.beizannum.text = @"0";
    wave.guanzhunum.text = @"0";
    wave.fensinum.text = @"0";
    wave.moneyLabel.text = @"在中数赚了0.00元";
       
    self.waveView = wave;
    
    [self scrollViewDidScroll:self.tableView];
    
    [self.tableView addSubview:wave];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth , wave.height)];

    [self loginBtnAndlab];
   
    self.shareLabel.hidden = YES;
    }
   
}



- (void)click {
    
    ZSLoginViewController *zslogin = [[ZSLoginViewController alloc]init];
    [self presentViewController:zslogin animated:YES completion:nil];
    
}




#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 80;
    }else {
        return 50;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    
    if (indexPath.section == 0) {
        
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
        im.image = [UIImage imageNamed:@"E53C392C-4434-4D0F-8E14-74E6DEF83AA7"];
        im.contentMode = UIViewContentModeScaleAspectFill;
        
        [cell addSubview:im];
        } else
        {
        NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
        cell.textLabel.text = dict[@"title"];
        cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    }

    NSString *username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (username != nil)
    {
        switch (indexPath.section) {
            case 1:
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = @"4";
                }
                if (indexPath.row == 1) {
                    cell.detailTextLabel.text = @"￥160000";
                }
                break;
                
            default:
                break;
        }
        

    }else{
        switch (indexPath.section) {
            case 1:
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = @"0";
                }
                if (indexPath.row == 1) {
                    cell.detailTextLabel.text = @"￥0";
                }
                break;
                
            default:
                break;
        }
        

        
        
    }

    
    
    cell.selected = YES;
    
    if ([cell.textLabel.text isEqualToString:@"清空缓存"]){
        
        cell.accessoryView = [[UIView alloc] init];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.dataList[indexPath.section][indexPath.row][@"controller"]){
        UIViewController *vc = [[self.dataList[indexPath.section][indexPath.row][@"controller"] alloc] init];
        
        
            vc.title = self.dataList[indexPath.section][indexPath.row][@"title"];
            
            //vc.view.backgroundColor = XLColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
        //[self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !section ? 1 : CGFLOAT_MIN;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.isShowWave) {
        [self.waveView starWave];
    }
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (fabs(offsetY) > 20) {
        self.showWave = YES;
    }
    else {
        self.showWave = NO;
    }
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.waveView stopWave];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        self.waveView.frame = CGRectMake(offsetY/2, offsetY, KScreenWidth - offsetY, 270 - offsetY);  // 修改头部的frame值就行了
    }
    
   // NSLog(@"%f,%f",self.waveView.height,self.tableView.tableHeaderView.height);
 
    NSString *username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSLog(@"username%@",username);
    
    if (username != nil)
    {
        self.loginbtn.hidden = YES;
        self.shareLabel.hidden = NO;

       
    }else{
        
        if (offsetY >= 70) {
            self.loginbtn.hidden = YES;
            self.shareLabel.hidden = YES;

        }else {
            self.loginbtn.hidden = NO;
            self.shareLabel.hidden = YES;

        }
    }
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
