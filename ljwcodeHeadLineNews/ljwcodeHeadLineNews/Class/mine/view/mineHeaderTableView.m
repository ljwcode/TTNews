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
        [loginButton setBackgroundImage:[UIImage imageNamed:@"profile_grid_login"] forState:UIControlStateNormal];
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [self addSubview:loginButton];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self);
            make.height.mas_equalTo(self.width/2);
            make.width.mas_equalTo(self.width/2);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
