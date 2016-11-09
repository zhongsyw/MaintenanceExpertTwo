//
//  XLWaveView.h
//  XLMiaoBo
//
//  Created by XuLi on 16/9/11.
//  Copyright © 2016年 XuLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLWaveView : UIImageView

- (instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName centerIcon:(NSString *)icon;


@property (nonatomic, assign) UILabel *fensinum;
@property (nonatomic, assign) UILabel *guanzhunum;
@property (nonatomic, assign) UILabel *beizannum;
@property (nonatomic, assign) UILabel *moneyLabel;
@property (nonatomic, weak) UILabel *nameLabel;
///** 去分享 */
//@property (nonatomic, assign) UILabel *shareLabel;
- (void)starWave;
- (void)stopWave;
//- (instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName centerIcon:(NSString *)icon namelabeltext:(NSString *)name money:(NSString*)money beizannum:(NSString *)bzn guanzhunum:(NSString *)gzn fensinum:(NSString *)fsn;

@end
