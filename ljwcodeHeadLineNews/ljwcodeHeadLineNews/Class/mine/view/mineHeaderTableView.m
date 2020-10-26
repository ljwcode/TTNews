//
//  mineHeaderTableView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "mineHeaderTableView.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>
#import "QRCodeViewController.h"
#import "SettingViewController.h"

@interface mineHeaderTableView()

@end

@implementation mineHeaderTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.3);
        
        UIButton *scanQRCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [scanQRCodeBtn setImage:[UIImage imageNamed:@"profile_scan_code"] forState:UIControlStateNormal];
        [scanQRCodeBtn addTarget:self action:@selector(scanQRCode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:scanQRCodeBtn];
        [scanQRCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vSpace);
            make.top.mas_equalTo(hSpace);
            make.width.height.mas_equalTo(40);
        }];
        
        UIButton *SettingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [SettingBtn setImage:[UIImage imageNamed:@"profile_system_config"] forState:UIControlStateNormal];
        [SettingBtn addTarget:self action:@selector(SettingHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:SettingBtn];
        [SettingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-vSpace);
            make.top.mas_equalTo(hSpace);
            make.width.height.mas_equalTo(40);
        }];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setImage:[UIImage imageNamed:@"profile_grid_login~iphone@2x"] forState:UIControlStateNormal];
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        
        loginButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -loginButton.titleLabel.intrinsicContentSize.width);
        loginButton.titleEdgeInsets = UIEdgeInsetsMake(0, -loginButton.imageView.intrinsicContentSize.width, 0, 0);
        
        [self addSubview:loginButton];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(self.width/2);
        }];
        loginButton.contentMode = UIViewContentModeScaleAspectFit;
        [loginButton addTarget:self action:@selector(loginHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark ----- 响应事件

-(void)SettingHandle:(UIButton *)sender{
    SettingViewController *SettingVC = [[SettingViewController alloc]init];
    [[self getCurrentViewController].navigationController pushViewController:SettingVC animated:YES];
}

-(void)scanQRCode:(UIButton *)sender{
    QRCodeViewController *QRCodeVC = [[QRCodeViewController alloc]init];
    [[self getCurrentViewController].navigationController pushViewController:QRCodeVC animated:YES];
}

-(void)loginHandle:(UIButton *)sender{
    if(sender){
        if(self.loginBlock){
            self.loginBlock();
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
