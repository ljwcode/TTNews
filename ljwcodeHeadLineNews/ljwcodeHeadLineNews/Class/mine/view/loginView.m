//
//  loginView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "loginView.h"
#import <Masonry/Masonry.h>
#import <YYText/YYText.h>

@interface loginView()

@property(nonatomic,weak)UIButton *closeBtn;

@property(nonatomic,weak)UIButton *questionBtn;

@property(nonatomic,weak)UILabel *titleLabel;

@end

@implementation loginView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)configureUI{
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(statuBarHeight);
        make.height.width.mas_equalTo(30);
    }];
    _closeBtn = closeBtn;
    
    UIButton *questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionBtn setTitle:@"遇到问题" forState:UIControlStateNormal];
    [questionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    questionBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:questionBtn];
    
    [questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(closeBtn);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    _questionBtn = questionBtn;
    
    UIImageView *titleImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"title-40-iphone"]];
    [self addSubview:titleImgView];
    
    [titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(closeBtn.mas_bottom).offset(60);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = [NSString stringWithFormat:@"今日头条"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:20.f];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleImgView.mas_right).offset(2);
        make.top.mas_equalTo(titleImgView);
        make.height.mas_equalTo(titleImgView);
    }];
    _titleLabel = titleLabel;
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"登陆即表示同意"];
    text.yy_font = [UIFont systemFontOfSize:18.f];
    text.yy_lineSpacing = 2.5;
    text.yy_color = [UIColor lightGrayColor];
    
    NSMutableAttributedString *userProtocolText = [[NSMutableAttributedString alloc]initWithString:@"\"用户协议\""];
    userProtocolText.yy_font = [UIFont systemFontOfSize:18.f];
    userProtocolText.yy_lineSpacing = 2.f;
    userProtocolText.yy_color = [UIColor blackColor];
    [userProtocolText yy_setTextHighlightRange:userProtocolText.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
    }];
    [text appendAttributedString:userProtocolText];
    
    NSMutableAttributedString *andText = [[NSMutableAttributedString alloc]initWithString:@"和"];
    andText.yy_font = [UIFont systemFontOfSize:18.f];
    andText.yy_lineSpacing = 2.f;
    andText.yy_color = [UIColor lightGrayColor];
    [text appendAttributedString:andText];
    
    NSMutableAttributedString *privacyPolicyText = [[NSMutableAttributedString alloc]initWithString:@"\"隐私政策\""];
    privacyPolicyText.yy_font = [UIFont systemFontOfSize:18.f];
    privacyPolicyText.yy_lineSpacing = 2.f;
    privacyPolicyText.yy_color = [UIColor blackColor];
    [privacyPolicyText yy_setTextHighlightRange:privacyPolicyText.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
    }];
    [text appendAttributedString:privacyPolicyText];
    
    YYLabel *tipLabel = [[YYLabel alloc]init];
    tipLabel.attributedText = text;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    tipLabel.numberOfLines = 1;
    [self addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(titleLabel).offset(25);
    }];
    
    
    UIButton *countryCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [countryCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    countryCodeBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self addSubview:countryCodeBtn];
    
    [countryCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipLabel);
        make.top.mas_equalTo(tipLabel.mas_bottom).offset(50);
        make.height.width.mas_equalTo(30);
    }];
    
    UITextField *phoneTextfield = [[UITextField alloc]init];
    phoneTextfield.placeholder = @"手机号";
    phoneTextfield.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:phoneTextfield.placeholder attributes:[NSDictionary dictionaryWithObjectsAndKeys:NSForegroundColorAttributeName,[UIColor grayColor],NSFontAttributeName,[UIFont systemFontOfSize:17.f], nil]];
    [self addSubview:phoneTextfield];
    
    [phoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(countryCodeBtn.mas_right);
        make.top.mas_equalTo(countryCodeBtn);
        make.height.mas_equalTo(countryCodeBtn);
    }];
    
    UIImageView *lineImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
