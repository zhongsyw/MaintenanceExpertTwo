//
//  ZSMineInfoViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/27.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMineInfoViewController.h"
#import "UIViewController+SelectPhotoIcon.h"
#import "BBInput.h"

@interface ZSMineInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *_array;
    NSMutableArray *_array2;

}

@property(nonatomic,strong)UITableView *tableview;;
@property(nonatomic,strong)UIImageView *userIcon;
@property (copy, nonatomic)UITableViewCell *nickNameCell;
@property (copy, nonatomic)UITableViewCell *signNameCell;
@end


@implementation ZSMineInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initarr];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.navigationItem.title = @"资料修改";
    
    _tableview = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableview.separatorColor = [UIColor colorWithRed:52.0f/255.0f green:53.0f/255.0f blue:61.0f/255.0f alpha:1];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)initarr {
    
    _array = [NSMutableArray arrayWithObjects:@"头像",@"昵称",@"个人简介", nil];
    self.userIconone = [[UIImageView alloc]init];
    MineInfModel *model = [[MineInfModel alloc]init];
    self.model = model;
    
    _nickNameCell = [[UITableViewCell alloc]init];
    _signNameCell = [[UITableViewCell alloc]init];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 50;
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (cell == nil) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    }
    
    if (indexPath.row == 0) {
        _userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - 90, 0, 80, 80)];
        self.userIcon.layer.cornerRadius = self.userIcon.bounds.size.width/2;
        self.userIcon.clipsToBounds = YES;
        _userIcon.image = self.model.usericon;
        [cell addSubview:_userIcon];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_array[indexPath.row]];
    if (indexPath.row == 1) {
        
        
        _nickNameCell = cell;
        
        return _nickNameCell;
    } if (indexPath.row == 2) {
        
        
        _signNameCell = cell;
        return _signNameCell;
    }else {
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: //头像
        {
            [self showActionSheet];
        }
            break;
        case 1: //昵称
        {
            [self updateNickName];
        }
            break;
        case 2: //签名
        {
            [self updateSignName];
        }
            break;
            
        default:
            break;
    }

    
}

//TODO:修改头像
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    
    //获得编辑后的图片
    UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    self.model.usericon = editedImage;
    self.userIcon.image = self.model.usericon;
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//TODO:修改昵称
-(void)updateNickName{
    
    [BBInput setDescTitle:@"请输入昵称"];
    [BBInput setMaxContentLength:10];
    [BBInput setNormalContent:self.nickNameCell.detailTextLabel.text];
    [BBInput showInput:^(NSString *inputContent) {
        
        self.nickNameCell.detailTextLabel.text = inputContent;
        
        
        [_tableview reloadData];
        
    }];
    
}

//TODO:修改个性签名
-(void)updateSignName{
    
    [BBInput setDescTitle:@"请输入个性签名"];
    [BBInput setMaxContentLength:50];
    [BBInput setNormalContent:self.signNameCell.detailTextLabel.text];
    [BBInput showInput:^(NSString *inputContent) {
        
        self.signNameCell.detailTextLabel.text = inputContent;
        
        [_tableview reloadData];
        
    }];
    
}



@end
