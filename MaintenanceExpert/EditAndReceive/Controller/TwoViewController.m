//
//  TwoViewController.m
//  XWPopMenuVCDemo
//
//  Created by xpc on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//
/*
 这是快捷下单页面
 */
#import "TwoViewController.h"
#import "TwoCollectionViewCell.h"
#import "TwoCategoryViewController.h"
#import "TwoDetailsViewController.h"
#import "ZLShowBigImage.h"

#define HEADERIMG_HEIGHT 64
@interface TwoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate,UITextFieldDelegate,shanchudelgate>

{
    UIImageView *headerImg;
    UIView *upView;
    UIView *midView;
    UIView *downView;       //
    UILabel *descriptLabel; //  描述
    UIView *slideBackView;     //  滑动按钮View
    UILabel *prace;        //  价格 Cell
    
}

@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *arrDataSources;
@property (strong, nonatomic) NSMutableArray *mutableArray;


@end

@implementation TwoViewController


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}


//
//- (void)viewWillDisappear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:BACK_GROUND_COLOR];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(finishPublish)];
    self.navigationItem.leftBarButtonItem = back;
    
    self.title = @"发 布";
    
    [self creatBakeWhiteColor];
    
    [self creatUpView];
    [self creatPhotoAngVideo];  //  添加图片、
    [self creatPosition];       //  添加地理位置
    [self creatSlider];         //  添加滑动条
    [self creatPrice];          //  添加价格
    [self creatMaintain];       //  添加维修按钮
    [self creatInstall];        //  添加安装按钮
    [self creatButton];         //  添加确定下单按钮
    
    
    //添加取消按钮->
    [self addCancelBtn];
    
}

#pragma mark - 添加控件

//  上、中、下 三块白色的背景
- (void)creatBakeWhiteColor {
    
    upView = [[UIView alloc] init];
    upView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:upView];
    upView.sd_layout.leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, HEADERIMG_HEIGHT)
    .rightSpaceToView(self.view, 0)
    .heightIs(self.view.frame.size.height/2 - 20);
    
    midView = [[UIView alloc] init];
    midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:midView];
    midView.sd_layout.leftEqualToView(upView)
    .topSpaceToView(upView, 10)
    .rightEqualToView(upView)
    .bottomSpaceToView(self.view, 90);
    
    downView = [[UIView alloc] init];
    downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downView];
    downView.sd_layout.leftEqualToView(midView)
    .rightEqualToView(midView)
    .bottomSpaceToView(self.view, 0)
    .heightIs(60);
    
}

//  Navigation、标题、描述
- (void)creatUpView {
    
    
    //  Navigation 发 布
    headerImg = [[UIImageView alloc] init];
    headerImg.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
    [self.view addSubview:headerImg];
    headerImg.sd_layout.leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(HEADERIMG_HEIGHT);

    UILabel *titleLable = [[UILabel alloc] init];
//    titleLable.backgroundColor = [UIColor purpleColor];
    titleLable.text = @"发 布";
    [titleLable setFont:[UIFont systemFontOfSize:18]];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerImg addSubview:titleLable];
    titleLable.sd_layout.leftSpaceToView(headerImg, self.view.frame.size.width / 2 - 30)
    .topSpaceToView(headerImg, 25)
    .bottomSpaceToView(headerImg, 5)
    .widthIs(60);
    
    
    //  标题
#warning 限制 输入字数！！！！！！！！！
    _titleTF = [[UITextField alloc] init];
    _titleTF.backgroundColor = [UIColor cyanColor];
    _titleTF.placeholder = @"标题";
    _titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_titleTF setFont:[UIFont systemFontOfSize:15]];
    _titleTF.returnKeyType = UIReturnKeyDone;
    _titleTF.delegate = self;
    [upView addSubview:_titleTF];
    _titleTF.sd_layout.leftSpaceToView(upView, 20)
    .topSpaceToView(upView, 5)
    .rightSpaceToView(upView, 20)
    .heightIs(30);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BACK_GROUND_COLOR;
    [upView addSubview:lineView];
    lineView.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(_titleTF, 5)
    .rightSpaceToView(upView, 0)
    .heightIs(1);
    
    //  描 述
#warning 限制 输入字数 / 行数！！！！！！！！！
    _descriptTV = [[UITextView alloc] init];
    _descriptTV.backgroundColor = [UIColor cyanColor];
    _descriptTV.delegate = self;
    [_descriptTV setFont:[UIFont systemFontOfSize:15]];
    [upView addSubview:_descriptTV];
    _descriptTV.sd_layout.leftSpaceToView(upView, 16)
    .topSpaceToView(lineView, 5)
    .rightEqualToView(_titleTF)
    .heightRatioToView(upView, 0.33);
    
    descriptLabel = [[UILabel alloc] init];
    descriptLabel.text = @" 请描述一下你的请求";
    descriptLabel.enabled = NO;
    descriptLabel.font = [UIFont systemFontOfSize:15];
    descriptLabel.textColor = [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1];
    [_descriptTV addSubview:descriptLabel];
    descriptLabel.sd_layout.leftSpaceToView(_descriptTV, 0)
    .topSpaceToView(_descriptTV, 0)
    .rightSpaceToView(_descriptTV, 0)
    .heightIs(30);
    
    
    
}

//  添加 图片、视频
- (void)creatPhotoAngVideo {
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.itemSize = CGSizeMake((KScreenWidth-85)/4, (KScreenWidth-85)/4);
    //layout1.minimumLineSpacing = 5;
    layout1.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KScreenHeight/2 - 140, KScreenWidth, KScreenWidth/4) collectionViewLayout:layout1];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.collectionView registerClass:[TwoCollectionViewCell class] forCellWithReuseIdentifier:@"TwoCollectionViewCell"];
    
    [upView addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}

//  添加 地理位置
- (void)creatPosition {
    
    UIImageView *imgV = [[UIImageView alloc] init];
    //    imgV.backgroundColor = [UIColor cyanColor];
    imgV.image = [UIImage imageNamed:@"111"];
    [upView addSubview:imgV];
    imgV.sd_layout.leftSpaceToView(upView, 15)
    .bottomSpaceToView(upView, 10)
    .widthIs(20)
    .heightIs(20);
    

    _addressLabel = [[UILabel alloc] init];
    //    _address.backgroundColor = [UIColor cyanColor];
    _addressLabel.text = @"山东 青岛 市北区";
    [_addressLabel setFont:[UIFont systemFontOfSize:13]];
    [upView addSubview:_addressLabel];
    _addressLabel.sd_layout.leftSpaceToView(imgV, 2)
    .topEqualToView(imgV)
    .bottomEqualToView(imgV)
    .rightSpaceToView(upView, 30);

#warning 这里添加一个 触摸/点击 事件，当点击这里的时候，跳转到 地图
    
    _addressLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *addressRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTouchUpInside:)];
    [_addressLabel addGestureRecognizer:addressRecognizer];
    
}


//  滑动按钮 价钱 横线
- (void)creatSlider {
    
    slideBackView = [[UIView alloc] init];
//    slideBackView.backgroundColor = [UIColor cyanColor];
    [midView addSubview:slideBackView];
    slideBackView.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(midView, 0)
    .rightEqualToView(_titleTF)
    .heightRatioToView(midView, 0.45);
    
    
    CGRect fram = CGRectMake(30, 5, KScreenWidth - 100, self.view.frame.size.height);
    NSArray *array = [NSArray arrayWithObjects:@"一口价",@"待技术勘察",@"协商价", nil];
    
    _filter = [[ZSFitterControl alloc] initWithFrame:fram Titles:array];
//    _filter.centerY = slideBackView.centerY;
    [_filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [_filter setProgressColor:[UIColor groupTableViewBackgroundColor]];   //设置滑杆的颜色
    [_filter setTopTitlesColor:[UIColor yellowColor]];  //设置滑块上方字体颜色
    [_filter setSelectedIndex:0];   //设置当前选中
    [slideBackView addSubview:_filter];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BACK_GROUND_COLOR;
    [midView addSubview:line];
    line.sd_layout.leftSpaceToView(midView, 0)
    .topSpaceToView(slideBackView, 0)
    .rightSpaceToView(midView, 0)
    .heightIs(1);
    
    
}

//  价格 横线
- (void)creatPrice {
    
    prace = [[UILabel alloc] init];
//    prace.backgroundColor = [UIColor cyanColor];
    prace.text = @"价格";
    [prace setFont:[UIFont systemFontOfSize:15]];
    prace.textColor = [UIColor blackColor];
    [midView addSubview:prace];
    prace.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(slideBackView, 1)
    .widthRatioToView(midView, 0.2)
    .heightRatioToView(midView, 0.25);
    
    _priceLabel = [[UILabel alloc] init];
//    _priceLabel.backgroundColor = [UIColor brownColor];
    _priceLabel.text = @"¥0.00";
    [_priceLabel setFont:[UIFont systemFontOfSize:15]];
    _priceLabel.textColor = [UIColor blackColor];
    [midView addSubview:_priceLabel];
    _priceLabel.sd_layout.leftSpaceToView(prace, 0)
    .topEqualToView(prace)
    .rightEqualToView(_titleTF)
    .heightRatioToView(midView, 0.25);
    
    //  添加点击事件
    _priceLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *priceLabelRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(praceTouchUpInside:)];
    [_priceLabel addGestureRecognizer:priceLabelRecognizer];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BACK_GROUND_COLOR;
    [midView addSubview:line];
    line.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(_priceLabel, 0)
    .rightSpaceToView(midView, 0)
    .heightIs(1);
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"web_forward_icon"];
    [_priceLabel addSubview:icon];
    icon.sd_layout.centerYEqualToView(_priceLabel)
    .rightSpaceToView(_priceLabel, 0)
    .widthIs(10)
    .heightRatioToView(_priceLabel, 0.5);
}

//  分类（ 维护Maintain、安装Install ）
//  维护 按钮
- (void)creatMaintain {
    
    _maintainBtn = [[UIButton alloc] init];
    _maintainBtn.backgroundColor = [UIColor magentaColor];
    [_maintainBtn setTitle:@"维 护" forState:UIControlStateNormal];
    [_maintainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_maintainBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _maintainBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_maintainBtn addTarget:self action:@selector(maintaBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    [midView addSubview:_maintainBtn];
    _maintainBtn.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(_priceLabel, 1)
    .widthIs(self.view.frame.size.width/2 - 20)
    .heightRatioToView(midView, 0.25);
    
    
}

//  安装 按钮
- (void)creatInstall {
    
    _installBtn = [[UIButton alloc] init];
    _installBtn.backgroundColor = [UIColor cyanColor];
    [_installBtn setTitle:@"安 装" forState:UIControlStateNormal];
    [_installBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_installBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _installBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_installBtn addTarget:self action:@selector(installBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    [midView addSubview:_installBtn];
    _installBtn.sd_layout.rightSpaceToView(midView, 20)
    .topEqualToView(_maintainBtn)
    .widthIs(self.view.frame.size.width/2 - 20)
    .heightRatioToView(midView, 0.25);
    
}

//  确认下单 按钮
- (void)creatButton {
    
    UIButton *confirmatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmatBtn = [[UIButton alloc] init];
    confirmatBtn.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
    [confirmatBtn setTitle:@"确定发布" forState:UIControlStateNormal];
    [confirmatBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [confirmatBtn addTarget:self action:@selector(confirmatButtonClick) forControlEvents:UIControlEventTouchDown];
    [downView addSubview:confirmatBtn];
    confirmatBtn.sd_layout.leftSpaceToView(downView, 12)
    .topSpaceToView(downView, 10)
    .rightSpaceToView(downView, 12)
    .bottomSpaceToView(downView, 10);
    
}

//  键盘响应事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//  地理位置 点击事件
- (void)addressTouchUpInside:(UITapGestureRecognizer *)recognizer {
    
    NSLog(@"选择地理位置");
}
#warning 价格点击事件
//  价格的 点击事件
- (void)praceTouchUpInside:(UITapGestureRecognizer *)recognizer {
    

}

//  维护的 点击事件
- (void)maintaBtnClick:(UIButton *)button {
    
    NSLog(@"已选择维护");
}

//  安装的 点击事件
- (void)installBtnClick:(UIButton *)button {
    
    NSLog(@"已选择安装");
}


#warning 如果 slider 没有选择，则弹出一个提示框！或者默认就是 0 ---------------------------
#pragma mark - 滑动按钮点击 响应事件
-(void)filterValueChanged:(ZSFitterControl *)sender
{
    NSLog(@"当前滑块位置%d",sender.SelectedIndex);
    switch (sender.SelectedIndex) {
        case 0:
            NSLog(@"一口价");
            break;
        case 1:
            NSLog(@"待技术勘察");
            break;
        case 2:
            NSLog(@"协商价");
            break;
        default:
            break;
    }
}

#pragma mark - 确定下单按钮
- (void)confirmatButtonClick {
    
    NSLog(@"确定发布----");
    
    TwoDetailsViewController *detailsVC = [[TwoDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}

#pragma mark - 键盘响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_titleTF resignFirstResponder];
    [_descriptTV resignFirstResponder];
}

#pragma mark - 取消下单按钮
//添加取消按钮->
- (void)addCancelBtn {
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setFrame:CGRectMake(10, 30, 40, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelTwoClick) forControlEvents:UIControlEventTouchUpInside];
}

//取消按钮点击方法
- (void)cancelTwoClick {
    [self finishPublish];
}

#pragma mark - 完成发布
//返回
-(void)finishPublish{
    //2.block传值
    if (self.mDismissBlock != nil) {
        self.mDismissBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];//
    //[self popoverPresentationController];
}
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text length] == 0) {
        [descriptLabel setHidden:NO];
    }else {
        [descriptLabel setHidden:YES];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.arrDataSources.count == 3) {
        
        return self.arrDataSources.count+1;
    }
    return self.arrDataSources.count+2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"TwoCollectionViewCell";
    
    TwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
#warning 有待改善
    
    cell.delgate = self;
    if (self.arrDataSources.count == 0) {
        if (indexPath.row == 0) {
            
            cell.imgView.image = [UIImage imageNamed:@"add.jpg"];
            cell.delBtn.hidden = YES;
        }else{
            
            cell.imgView.image = [UIImage imageNamed:@"add1.jpg"];
            cell.delBtn.hidden = YES;
        }
        
    }else if (self.arrDataSources.count <3){
        
        if (indexPath.row == self.arrDataSources.count) {
            
            cell.imgView.image = [UIImage imageNamed:@"add.jpg"];
            cell.delBtn.hidden = YES;
        }else if (indexPath.row == self.arrDataSources.count+1){
            
            cell.imgView.image = [UIImage imageNamed:@"add1.jpg"];
            cell.delBtn.hidden = YES;
        }else{
            
            cell.imgView.image = self.arrDataSources[indexPath.row];
            cell.delBtn.hidden = NO;
        }
        
    }else {
        
        if (indexPath.row == self.arrDataSources.count) {
            
            cell.imgView.image = [UIImage imageNamed:@"add1.jpg"];
            cell.delBtn.hidden = YES;
            
        }else{
            cell.delBtn.hidden = NO;
            cell.imgView.image = self.arrDataSources[indexPath.row];
        }
    }
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 25, 0, 25);
}


#warning 有待改善
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.arrDataSources.count == 0) {
        
        if (indexPath.row == 0) {
            
            [self showPhotoLibrary];
        }else{
            
            NSLog(@"视频位置");
        }
    }else if (self.arrDataSources.count<3){
        
        if (indexPath.row == self.arrDataSources.count) {
            
            [self showPhotoLibrary];
        }else if(indexPath.row == self.arrDataSources.count+1){
            
            NSLog(@"视频位置");
        }
        
    }else if (self.arrDataSources.count == 3){
        
        if (indexPath.row == self.arrDataSources.count) {
            
            NSLog(@"视频位置");
        }
    }
    
#warning 有待改善
    
    //  查看放大的图片
    if (self.arrDataSources.count > 0 && indexPath.row == 0) {
        
        TwoCollectionViewCell *cell = (TwoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [ZLShowBigImage showBigImage:cell.imgView];
    }
    if (self.arrDataSources.count > 1 && indexPath.row == 1) {
        TwoCollectionViewCell *cell = (TwoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [ZLShowBigImage showBigImage:cell.imgView];
    }
    if (self.arrDataSources.count > 2 && indexPath.row == 2) {
        TwoCollectionViewCell *cell = (TwoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [ZLShowBigImage showBigImage:cell.imgView];
    }
}

#warning 删除图片这里 有问题！！！  NSArray --- NSMutableArray

#pragma mark - shanchuDelegate
- (void)shanchudelgate:(UICollectionViewCell *)cell{
   
    //  转换 有问题？
    _mutableArray = [_arrDataSources mutableCopy];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [_mutableArray removeObjectAtIndex:indexPath.row];
    
    NSLog(@"删除不掉-有问题--！！！！-%ld", indexPath.row);
    
    [self.collectionView reloadData];

}


//  打开相册 选择图片
- (void)showPhotoLibrary {
    
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置最大选择数量
    actionSheet.maxSelectCount = 3;
    weakify(self);
    
    [actionSheet showPhotoLibraryWithSender:self lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
    
        strongify(weakSelf);
        strongSelf.arrDataSources = selectPhotos;
        strongSelf.lastSelectMoldels = selectPhotoModels;
        [strongSelf.collectionView reloadData];
        NSLog(@"%@", selectPhotos);
        
    }];
}


@end
