



//
//  XLWaveView.m
//  XLMiaoBo
//
//  Created by XuLi on 16/9/11.
//  Copyright © 2016年 XuLi. All rights reserved.
//

#import "XLWaveView.h"
#import "Masonry.h"
#import "UIView+ZSExtension.h"

#define XLScreenW [UIScreen mainScreen].bounds.size.width

@interface XLWaveView ()


/**
 *  波纹的振幅   amplitude （振幅）
 */
@property (nonatomic, assign) CGFloat waveAmplitude;

/**
 *  波纹的传播周期  单位s    period (周期)
 */
@property (nonatomic, assign) CGFloat wavePeriod;

/**
 *  波纹的长度
 */
@property (nonatomic, assign) CGFloat waveLength;

/** 偏移量 */
@property (nonatomic, assign) CGFloat offsetX;
/** 定时器 */
@property (nonatomic, strong) CADisplayLink *link;
/** 形状视图 */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
/** 头像 */
@property (nonatomic, assign) UIImageView *icon;
/** 赚了多少钱 */
//@property (nonatomic, assign) UILabel *moneyLabel;
/** 去分享 */
@property (nonatomic, assign) UILabel *shareLabel;

//@property (nonatomic, weak) UILabel *nameLabel;

/** 被赞 */
@property (nonatomic, assign) UILabel *beizan;
//@property (nonatomic, assign) UILabel *beizannum;
/** 被关注 */
@property (nonatomic, assign) UILabel *guanzhu;
//@property (nonatomic, assign) UILabel *guanzhunum;
/** 粉丝数 */
@property (nonatomic, assign) UILabel *fensi;
//@property (nonatomic, assign) UILabel *fensinum;

@property (nonatomic,strong) UIView *lineView;



@end

@implementation XLWaveView


- (UIView *)lineView
{
    if (_lineView == nil) {
        UIView *lineView = [[UIView alloc]init];
        [self addSubview:lineView];
        lineView.sd_layout.leftEqualToView(self.beizannum)
                            .rightEqualToView(self.fensinum)
                            .bottomSpaceToView(self.beizannum,1)
                            .heightIs(1);
        
  
        _lineView = lineView;
    }
    return _lineView;
}

- (UILabel *)beizan
{
    if (_beizan == nil){
        
        UILabel *beizan = [[UILabel alloc] init];
        
        beizan.numberOfLines = 0;
        

        beizan.textColor = [UIColor whiteColor];
        
        [self addSubview:beizan];
        
        beizan.sd_layout.leftSpaceToView(self,KScreenWidth / 10)
                        .bottomSpaceToView(self,5)
                        .heightIs(40)
                        .widthIs(KScreenWidth * 0.8 /3);
        beizan.font = [UIFont systemFontOfSize:18];
        beizan.textAlignment = NSTextAlignmentCenter;
        _beizan = beizan;
    }
    
    return _beizan;
}

- (UILabel *)beizannum
{
    if (_beizannum == nil){
        
        UILabel *beizannum = [[UILabel alloc] init];
        
        beizannum.numberOfLines = 0;
        
        
        beizannum.textColor = [UIColor blackColor];
        
        [self addSubview:beizannum];
        
        beizannum.sd_layout.leftEqualToView(self.beizan)
                            .bottomSpaceToView(self.beizan,-10)
                            .heightIs(40)
                            .widthIs(KScreenWidth * 0.8 /3);
        beizannum.font = [UIFont systemFontOfSize:18];
        beizannum.textAlignment = NSTextAlignmentCenter;
        _beizannum = beizannum;
    }
    
    return _beizannum;
}


- (UILabel *)guanzhu
{
    if (_guanzhu == nil){
        
        UILabel *guanzhu = [[UILabel alloc] init];
        
        guanzhu.numberOfLines = 0;
        
        guanzhu.textColor = [UIColor whiteColor];
        
        [self addSubview:guanzhu];
        
        guanzhu.sd_layout.leftSpaceToView(self.beizan, 0)
                            .bottomEqualToView(self.beizan)
                            .topEqualToView(self.beizan)
                            .widthIs(KScreenWidth * 0.8 /3);
        guanzhu.font = [UIFont systemFontOfSize:18];
        guanzhu.textAlignment = NSTextAlignmentCenter;
        _guanzhu = guanzhu;
    }
    
    return _guanzhu;
}

- (UILabel *)guanzhunum
{
    if (_guanzhunum == nil){
        
        UILabel *guanzhunum = [[UILabel alloc] init];
        
        guanzhunum.numberOfLines = 0;
        
        
        guanzhunum.textColor = [UIColor blackColor];
        
        [self addSubview:guanzhunum];
        
        guanzhunum.sd_layout.leftSpaceToView(self.beizannum,0)
                            .bottomEqualToView(self.beizannum)
                            .topEqualToView(self.beizannum)
                            .widthIs(KScreenWidth * 0.8 /3);
        guanzhunum.font = [UIFont systemFontOfSize:18];
        guanzhunum.textAlignment = NSTextAlignmentCenter;
        _guanzhunum = guanzhunum;
    }
    
    return _guanzhunum;
}


- (UILabel *)fensi
{
    if (_fensi == nil){
        
        UILabel *fensi = [[UILabel alloc] init];
        
        fensi.numberOfLines = 0;
        
        fensi.textColor = [UIColor whiteColor];
        
        [self addSubview:fensi];
        
        fensi.sd_layout.leftSpaceToView(self.guanzhu, 0).bottomEqualToView(self.beizan).topEqualToView(self.beizan).widthIs(KScreenWidth * 0.8 /3);
        fensi.font = [UIFont systemFontOfSize:18];
        fensi.textAlignment = NSTextAlignmentCenter;
        _fensi = fensi;
    }
    
    return _fensi;
}
- (UILabel *)fensinum
{
    if (_fensinum == nil){
        
        UILabel *fensinum = [[UILabel alloc] init];
        
        fensinum.numberOfLines = 0;
        
        
        fensinum.textColor = [UIColor blackColor];
        
        [self addSubview:fensinum];
        
        fensinum.sd_layout.leftSpaceToView(self.guanzhunum,0).bottomEqualToView(self.beizannum).topEqualToView(self.beizannum).widthIs(KScreenWidth * 0.8 /3);
        fensinum.font = [UIFont systemFontOfSize:18];
        fensinum.textAlignment = NSTextAlignmentCenter;
        _fensinum = fensinum;
    }
    
    return _fensinum;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil){
        
        UILabel *nameLabel = [[UILabel alloc] init];
        
        nameLabel.numberOfLines = 0;
        
        nameLabel.text = @"昵称";
        nameLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:nameLabel];
        
        nameLabel.sd_layout.leftSpaceToView(self,KScreenWidth / 10)
                            .topSpaceToView(self,64)
                            .heightIs(50)
                            .widthIs(200);
        nameLabel.font = [UIFont systemFontOfSize:30];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel = nameLabel;
    }
    
    return _nameLabel;
}

- (UILabel *)moneyLabel {
    
    if (_moneyLabel == nil) {
        UILabel *money = [[UILabel alloc]init];
        money.textAlignment = NSTextAlignmentLeft;
        money.numberOfLines = 0;
        
        money.text = @"赚钱";
        //money.textColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:85.0/255.0];
        money.textColor = [UIColor whiteColor];
        [self addSubview:money];
        
        money.sd_layout.leftEqualToView(self.nameLabel)
                        .topSpaceToView(self.nameLabel,10)
                        .heightIs(30)
                        .widthIs(165);
        money.font = [UIFont systemFontOfSize:15];

        
        _moneyLabel = money;
    }
    return _moneyLabel;
}

- (UILabel *)shareLabel {
    
    if (_shareLabel == nil) {
        UILabel *shareLabel = [[UILabel alloc]init];
        shareLabel.text = @"去炫耀";
        shareLabel.textColor = [UIColor blueColor];
        shareLabel.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:shareLabel];
        //[shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
        shareLabel.sd_layout.leftSpaceToView(self.moneyLabel,0)
                            .topEqualToView(self.moneyLabel)
                            .bottomEqualToView(self.moneyLabel)
                            .rightSpaceToView(self.icon,0);
        
        
        
        _shareLabel = shareLabel;
        
    }
    
    return _shareLabel;
}

- (UIImageView *)icon
{
    if (_icon == nil){
    
        UIImageView *icon = [[UIImageView alloc] init];
        
        icon.height = icon.width = KScreenWidth/5;
        icon.layer.cornerRadius = icon.width * 0.5;
        icon.layer.masksToBounds = YES;
//        nameLabel.sd_layout.leftSpaceToView(self,KScreenWidth / 10)
//        .topSpaceToView(self,64)
//        .heightIs(50)
//        .widthIs(200);
        icon.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:icon];
        
        icon.sd_layout.topSpaceToView(self,64)
                        .rightSpaceToView(self,KScreenWidth / 10)
                        .heightIs(KScreenWidth/5)
                        .widthIs(KScreenWidth/5);

        
        _icon = icon;
    }
    return _icon;
}


- (instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName centerIcon:(NSString *)icon
{
    self = [super initWithFrame:frame];
    if (self){
    
    self.contentMode = UIViewContentModeScaleToFill;
    self.image = [UIImage imageNamed:imageName];//背景
    self.icon.image = [UIImage imageNamed:icon];//头像
    self.nameLabel.text = @"王欣誉";
    self.beizan.text = @"被赞数";
        self.beizannum.text = @"18";
    self.guanzhu.text = @"关注数";
        self.guanzhunum.text = @"20";
    self.fensi.text = @"粉丝数";
        self.fensinum.text = @"2";
    self.lineView.backgroundColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:85.0/255.0];
    self.moneyLabel.text = @"在中数赚了1830.00元";
        self.shareLabel.textAlignment = NSTextAlignmentLeft;
        self.wavePeriod = 1;
        self.waveLength = XLScreenW;
    }
    return self;
}


- (void)starWave {
    
    self.waveAmplitude = 6.0;
    self.shapeLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.shapeLayer];
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    //【**波动画关键**】 一秒执行60次（算是CADisplayLink特性），即每一秒执行 setShapeLayerPath 方法60次
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setShapeLayerPath)];
    
    
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)setShapeLayerPath {
    
    // 振幅不断减小，波执行完后为0 （使波浪更逼真些）
    self.waveAmplitude -= 0.02; // 2s 后为0
    
    if (self.waveAmplitude < 0.1) {
        [self stopWave];
    }
    
    // 每次执行画的正玄线平移一小段距离 （SCREEN_W / 60 / wavePeriod，1s执行60次，传播周期为wavePeriod,所以每个波传播一个屏幕的距离） 从而形成波在传播的效果
    
    self.offsetX += (XLScreenW / 60 / self.wavePeriod);
    _shapeLayer.path = [[self currentWavePath] CGPath];
}


// UIBezierPath 画线
- (UIBezierPath *)currentWavePath {
    
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 设置线宽
    p.lineWidth = 2.0;
    
    CGPathMoveToPoint(path, nil, 0, self.height);
    CGFloat y = 0.0f;
    
    for (float x = 0.0f; x <= XLScreenW; x++) {
        
        /**
         * *** 正玄波的基础知识  ***
         *
         *  f(x) = Asin(ωx+φ)+k
         *
         *  A    为振幅, 波在上下振动时的最大偏移
         *
         *  φ/w  为在x方向平移距离
         *
         *  k    y轴偏移，即波的振动中心线y坐标与x轴的偏移距离
         *
         *  2π/ω 即为波长，若波长为屏幕宽度即， SCREEN_W = 2π/ω, ω = 2π/SCREEN_W
         */
        
        y = _waveAmplitude * sinf((2 * M_PI / _waveLength) * (x + _offsetX + _waveLength / 12)) + self.height - _waveAmplitude;
        
        // A = waveAmplitude  w = (2 * M_PI / waveLength) φ = (waveLength / 12) / (2 * M_PI / waveLength) k = headHeight - waveAmplitude （注意：坐标轴是一左上角为原点的）
        CGPathAddLineToPoint(path, nil, x, y);
        
    }
    
    CGPathAddLineToPoint(path, nil, XLScreenW, self.height);
    CGPathCloseSubpath(path);
    p.CGPath = path;
    CGPathRelease(path);
    return p;
}

- (void)stopWave {
    
    [self.shapeLayer removeFromSuperlayer];
    [self.link invalidate];
    self.link = nil;
}

@end
