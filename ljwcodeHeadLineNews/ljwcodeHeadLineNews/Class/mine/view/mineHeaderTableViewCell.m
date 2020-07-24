//
//  mineHeaderTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "mineHeaderTableViewCell.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@interface mineHeaderTableViewCell()

@property(nonatomic,weak)UIButton *loginButton;

@end

@implementation mineHeaderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self);
            make.height.mas_equalTo(self.height/2);
            make.width.mas_equalTo(self.width/2);
        }];
    }
    return self;
}

-(UIButton *)loginButton{
    if(!_loginButton){
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setImage:[UIImage imageNamed:@"kaixinicon_setup"] forState:UIControlStateNormal];
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [self.contentView addSubview:loginButton];
        _loginButton = loginButton;
    }
    return _loginButton;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
