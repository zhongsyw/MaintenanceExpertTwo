//
//  ZSMessageView.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMessageView.h"

@implementation ZSMessageView

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //背景图片
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageview.image = [UIImage imageNamed:@"93S58PICcXy_1024_meitu_1"];
    [self.view addSubview:imageview];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    
    
    [self initcontrols];
    
    [self createUI];
    ////@property(nonatomic,strong)UITextField *phoneTextfield;
    ////@property(nonatomic,strong)UITextField *messageTextfield;
    ////@property(nonatomic,strong)UIButton *messageBtn;
    ////@property(nonatomic,strong)UIButton *loginBtn;

}


- (void)initcontrols {
    
    _phoneTF = [[UITextField alloc]init];
    
    _messageTF = [[UITextField alloc]init];
    
    _messageBtn = [[UIButton alloc]init];
    
    _loginBtn = [[UIButton alloc]init];
    
    [self.view addSubview:_phoneTF];
    
    [self.view addSubview:_messageTF];

    [self.view addSubview:_messageBtn];
    
    [self.view addSubview:_loginBtn];
}

/**
 *  搭建界面
 */
- (void)createUI {
    
    UILabel *logolb = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth / 3, KScreenHeight * 0.2, KScreenWidth / 3, (KScreenWidth / 3) / 2 )];
    logolb.center = CGPointMake(KScreenWidth / 2, KScreenHeight * 0.2);
    [logolb setTextAlignment:NSTextAlignmentCenter];
    logolb.text = @"运维专家";
    logolb.textColor = [UIColor whiteColor];
    logolb.font = [UIFont systemFontOfSize:30 weight:5];
    [self.view addSubview:logolb];
    
    _phoneTF.sd_layout.leftSpaceToView(self.view,30)
                        .rightSpaceToView(self.view,30)
                        .yIs(KScreenHeight / 2 - 100)
                        .heightIs(40);
    _phoneTF.placeholder = @"请输入手机号";
    [_phoneTF setValue:[UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneTF setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    
    
    UIView *lineView = [[UIView alloc]init];
    [self.view addSubview:lineView];
    lineView.sd_layout.leftEqualToView(_phoneTF)
    .rightEqualToView(_phoneTF)
    .topSpaceToView(_phoneTF,2)
    .heightIs(1);
    lineView.backgroundColor = [UIColor blackColor];
    
    
    _messageTF.sd_layout.leftEqualToView(_phoneTF)
                        .topSpaceToView(_phoneTF,20)
                        .rightSpaceToView(self.view,30 + 110)
                        .heightIs(40);
    _messageTF.placeholder = @"请输入验证码";
    [_messageTF setValue:[UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_messageTF setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _messageTF.clearButtonMode = UITextFieldViewModeAlways;
    
    /**
     验证码按钮
     */
    
    [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    _messageBtn.sd_layout.leftSpaceToView(_messageTF,10)
                         .rightEqualToView(_phoneTF)
                         .topEqualToView(_messageTF)
                         .bottomEqualToView(_messageTF);
    
    _messageBtn.backgroundColor = [UIColor colorWithRed:41.0 / 255.0 green:182.0 / 255.0 blue:246.0 / 255.0 alpha:1];
    
    [_messageBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchDown];
    
    UIView *lineView1 = [[UIView alloc]init];
    [self.view addSubview:lineView1];
    lineView1.sd_layout.leftEqualToView(_phoneTF)
                        .rightEqualToView(_phoneTF)
                        .topSpaceToView(_messageTF,2)
                        .heightIs(1);
    lineView1.backgroundColor = [UIColor blackColor];
    
    /**
     登录按钮
     */
    
    _loginBtn.sd_layout.leftEqualToView(_phoneTF)
                        .rightEqualToView(_phoneTF)
                        .topSpaceToView(lineView1,50)
                        .heightIs(40);
    
    _loginBtn.backgroundColor = [UIColor colorWithRed:41.0 / 255.0 green:182.0 / 255.0 blue:246.0 / 255.0 alpha:1];
    [_loginBtn setTitle:@"登        陆" forState:UIControlStateNormal];
    _loginBtn.layer.cornerRadius = 10;
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    
}

/**
 *  登录
 */
- (void)login {
    
    NSLog(@"验证码登录");
}

/**
 *  验证码的计时器
 */
- (void)startTime {
    
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                
                [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                _messageBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [_messageBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
                _messageBtn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
            
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}


/**
 *  键盘响应
 *
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneTF resignFirstResponder];
    [_messageTF resignFirstResponder];
}



@end
