//
//  TwoCategoryViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "TwoCategoryViewController.h"
#import "HXTagsView.h"

@interface TwoCategoryViewController ()

@end











#warning 待使用界面！！！！！！！！！！！！！！！！！！！




@implementation TwoCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //单行不滚动 ===============
    NSArray *tagAry = @[@"英雄联盟",@"穿越火线",@"地下城与勇士"];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 200, 20)];
    titleLable.text = @"单行不滚动";
    [self.view addSubview:titleLable];
    
    //单行不需要设置高度,内部根据初始化参数自动计算高度
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, 0)];
    tagsView.type = 1;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    //单行滚动  ===============
    tagAry = @[@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"单行滚动";
    [self.view addSubview:titleLable];
    
    //单行不需要设置高度,内部根据初始化参数自动计算高度
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, 0)];
    tagsView.type = 1;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    //多行不滚动 ===============
    tagAry = @[@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪",@"跑跑卡丁车",@"传奇世界",@"劲舞团",@"激战2"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"多行平铺";
    [self.view addSubview:titleLable];
    
    //多行不滚动,则计算出全部展示的高度,让maxHeight等于计算出的高度即可,初始化不需要设置高度
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, 0)];
    tagsView.type = 0;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    //多行滚动 ===============
    tagAry = @[@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵",@"天龙八部3",@"qq三国",@"倩女幽魂ol",@"御龙在天"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"多行滚动";
    [self.view addSubview:titleLable];
    
    //多行滚动需要设置HXTagsView高度,当高度小于计算出的实际高度时,则自动滚动展示
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, 100)];
    tagsView.type = 0;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    
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
