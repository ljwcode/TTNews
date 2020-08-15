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

@interface mineHeaderTableView()

@end

@implementation mineHeaderTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.3);
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [loginButton setBackgroundImage:[UIImage imageNamed:@"profile_grid_login~iphone@2x"] forState:UIControlStateNormal];
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
