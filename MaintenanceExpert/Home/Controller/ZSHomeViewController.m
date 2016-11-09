//
//  ZSHomeViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/25.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHomeViewController.h"
#import "SDCycleScrollView.h"
#import "ZSHomeTableViewCell.h"


@interface ZSHomeViewController ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>

{
    UIButton *leftTitleBtn;
    UIButton *rightTitltBtn;
    UIBarButtonItem *rightBarBtn;
}


@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ZSHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//  二级页面 显示 NavigationBar
//- (void)viewWillDisappear:(BOOL)animated {
//    
//    [super viewWillDisappear:animated];
//    
//    if ( self.navigationController.childViewControllers.count > 1 ) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.navigationBarHidden = NO;
    
    [self creatNavigationView];
    [self creatTableView];
    [self creatTabelViewHeader];
}


#warning 这里 差两个 图片没添加
//  发现、我的、 搜索按钮
- (void)creatNavigationView {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth/3, 44)];
//    titleView.backgroundColor = [UIColor cyanColor];
    
//  发现
    leftTitleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width/2, 44)];
//    leftTitleBtn.backgroundColor = [UIColor redColor];
    [leftTitleBtn setTitle:@"发现" forState:UIControlStateNormal];
    leftTitleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [leftTitleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftTitleBtn addTarget:self action:@selector(leftTitleBtnClick) forControlEvents:UIControlEventTouchDown];
    [titleView addSubview:leftTitleBtn];
    
//  我的
    rightTitltBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleView.frame.size.width/2, 0, titleView.frame.size.width/2, 44)];
//    rightTitltBtn.backgroundColor = [UIColor yellowColor];
    [rightTitltBtn setTitle:@"我的" forState:UIControlStateNormal];
    [rightTitltBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightTitltBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightTitltBtn addTarget:self action:@selector(rightTitltBtnClick) forControlEvents:UIControlEventTouchDown];
    [titleView addSubview:rightTitltBtn];

    self.navigationItem.titleView = titleView;
    
    
//  搜索
    rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SearchIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
}


- (void)creatTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    [self.view addSubview:_tableView];
}

//  轮播图
- (void)creatTabelViewHeader {
    
    NSArray *imagesURLStrings = @[
                                  @"http://img2.3lian.com/2014/c7/12/d/77.jpg",
                                  @"http://img2.pconline.com.cn/pconline/0706/19/1038447_34.jpg",
                                  @"http://img3.iqilu.com/data/attachment/forum/201308/21/192654ai88zf6zaa60zddo.jpg"
                                  ];
    
    SDCycleScrollView *headSV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight*0.209) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    headSV.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    headSV.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    headSV.imageURLStringsGroup = imagesURLStrings;
    _tableView.tableHeaderView = headSV;
    
}


- (void)leftTitleBtnClick {
    
    NSLog(@"发   现----");
}

- (void)rightTitltBtnClick {
    
    NSLog(@"我   的----");
}

- (void)searchButtonClick {
    
    NSLog(@"搜   索----");
}


//  刷新 当前位置
- (void)refreshButtonClick {
    
    NSLog(@"刷新当前位置------");
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
#warning 查看更多，跳转到另一个页面
    if (indexPath.row == 5) {
        
        NSLog(@"查看更多");
    }
    
    NSLog(@"cell 被点击");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return 30;
    }else if (indexPath.row == 1) {
        
        return KScreenHeight * 0.3;
    }
    
    return KScreenHeight * 0.09;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"HomeTableVieCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        if (indexPath.row == 0) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 30)];
            label.text = @"附近的信息";
            [label setFont:[UIFont systemFontOfSize:15]];
            [cell addSubview:label];

            
//  刷新当前位置
            
            UIButton *refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 40, 0, 30, 30)];
            [refreshBtn setImage:[UIImage imageNamed:@"home_header_refresh"] forState:UIControlStateNormal];
            [refreshBtn addTarget:self action:@selector(refreshButtonClick) forControlEvents:UIControlEventTouchDown];
            [cell addSubview:refreshBtn];
            
            
//  当前位置
            
            UILabel *nowAddress = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth / 2 - 40, 0, KScreenWidth / 2, 30)];
            nowAddress.text = @"敦化路160号华仁丶欧典商苑";
            nowAddress.textColor = [UIColor grayColor];
            [nowAddress setFont:[UIFont systemFontOfSize:12]];
            nowAddress.textAlignment = NSTextAlignmentRight;
            [cell addSubview:nowAddress];
            
            
        }else if (indexPath.row == 1) {
            
  
#warning 地图  待添加！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 80)];
            label.text = @"这里是地图IndexPath.Row=1";
            label.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:label];
            
            

//  三个订单
        }else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, KScreenHeight * 0.09)];
            label.text = @"这里是其余的Cell";
            label.textAlignment = NSTextAlignmentCenter;

            [cell addSubview:label];

//  查看更多
        }else if (indexPath.row == 5){
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight * 0.044)];
            label.text = @"更多";
            label.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:label];
            
        }
    }
    
    return cell;
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"---点击了第%ld张图片", (long)index);
    
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
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
