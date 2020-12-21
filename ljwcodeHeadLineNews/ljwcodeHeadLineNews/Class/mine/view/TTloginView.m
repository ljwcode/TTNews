//
//  TTloginView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTloginView.h"
#import <YYText/YYText.h>
#import "countryCodeView.h"
#import "otherLoginTypeView.h"

@interface TTloginView()

@property(nonatomic,weak)UIButton *tiktokLoginBtn;

@property(nonatomic,weak)UIButton *countryCodeBtn;

@property(nonatomic,strong)otherLoginTypeView *otherView;

@end

@implementation TTloginView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardshow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor whiteColor];
        [self configureUI];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClose:)];
//        tap.delegate = self;
//        [self addGestureRecognizer:tap];
    }
    return self;
}

/*
 点击空白处关闭
 */

-(void)tapClose:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        CGPoint tapPoint = [tap locationInView:self];
        CGRect floatRect = self.otherView.bounds;
        
        if (self.otherView && !CGRectContainsPoint(floatRect, tapPoint))
        {
            [self removeGestureRecognizer:tap];
            [UIView animateWithDuration:0.5 animations:^{
                CGRect rect = self.otherView.frame;
                rect.origin.y += kScreenHeight;
                self.otherView.frame = rect;
            }];
            [self.otherView removeFromSuperview];
        }
    }
}

-(void)keyboardshow:(NSNotification *)noti{
    CGRect keyboardFrame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    CGFloat keyboarHeight = keyboardFrame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        [self.tiktokLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(systemVersion >= 13.0 ? self.width/3 : self.width*2/5);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-(20+keyboarHeight));
            make.width.height.mas_equalTo(self.width * 0.1);
        }];
    }];
    
}

-(void)keyboardHide:(NSNotification *)noti{
    [UIView animateWithDuration:0.25 animations:^{
        [self.tiktokLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(systemVersion >= 13.0 ? self.width/3 : self.width*2/5);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-(20));
            make.width.height.mas_equalTo(self.width * 0.1);
        }];
    }];
}

-(void)configureUI{
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close_sdk_register"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(statuBarHeight);
        make.height.width.mas_equalTo(30);
    }];
    
    UIButton *questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionBtn setTitle:@"遇到问题" forState:UIControlStateNormal];
    [questionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    questionBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:questionBtn];
    
    [questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-0);
        make.top.mas_equalTo(closeBtn);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    UIImageView *titleImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"title-40-iphone"]];
    [self addSubview:titleImgView];
    
    [titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(closeBtn.mas_bottom).offset(60);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = [NSString stringWithFormat:@"手机登录"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:20.f];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleImgView.mas_right).offset(2);
        make.top.mas_equalTo(titleImgView);
        make.height.mas_equalTo(titleImgView);
    }];    
    
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
    [self addSubview:tipLabel];

    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleImgView);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(titleLabel).offset(20);
    }];


    UIButton *countryCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [countryCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    countryCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [countryCodeBtn setTitle:@"+86" forState:UIControlStateNormal];
    [self addSubview:countryCodeBtn];
    _countryCodeBtn = countryCodeBtn;
    [countryCodeBtn addTarget:self action:@selector(countryCodeHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    [countryCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleImgView);
        make.top.mas_equalTo(titleImgView.mas_bottom).offset(50);
        make.height.width.mas_equalTo(50);
    }];

    UITextField *phoneTextfield = [[UITextField alloc]init];
    phoneTextfield.placeholder = @"手机号";
    phoneTextfield.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:phoneTextfield.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:17.f]}];
    [self addSubview:phoneTextfield];

    [phoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(countryCodeBtn.mas_right);
        make.top.mas_equalTo(countryCodeBtn);
        make.height.mas_equalTo(countryCodeBtn);
    }];

    UIView *lineImgView = [[UIView alloc]init];
    lineImgView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineImgView];
    [lineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(countryCodeBtn);
        make.top.mas_equalTo(countryCodeBtn.mas_bottom).offset(2);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(2);
    }];

    UILabel *tipSecLabel = [[UILabel alloc]init];
    tipSecLabel.text = @"未注册的手机号验证通过后将自动注册";
    tipSecLabel.textColor = [UIColor grayColor];
    tipSecLabel.font = [UIFont systemFontOfSize:13.f];
    tipSecLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipSecLabel];

    [tipSecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineImgView);
        make.top.mas_equalTo(lineImgView.mas_bottom).offset(5);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(lineImgView.height*0.75);
    }];

    UIButton *verifyCodeLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyCodeLoginBtn setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [verifyCodeLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verifyCodeLoginBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    verifyCodeLoginBtn.layer.cornerRadius = 2.f;
    [self addSubview:verifyCodeLoginBtn];

    [verifyCodeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipSecLabel);
        make.top.mas_equalTo(tipSecLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(phoneTextfield.height);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];

    UIButton *tiktokLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tiktokLoginBtn setImage:[UIImage imageNamed:@"douyin_sdk_login"] forState:UIControlStateNormal];
    [self addSubview:tiktokLoginBtn];
    _tiktokLoginBtn = tiktokLoginBtn;

    [tiktokLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(systemVersion >= 13.0 ? self.width/3 : self.width*2/5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
        make.width.height.mas_equalTo(self.width * 0.1);
    }];

    UIButton *appleLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    [appleLogin setImage:[UIImage imageNamed:@"login_v3_apple"] forState:UIControlStateNormal];
    [self addSubview:appleLogin];
    appleLogin.hidden = systemVersion >= 13.0 ? NO : YES;
    [appleLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tiktokLoginBtn.mas_right).offset(5);
        make.bottom.mas_equalTo(tiktokLoginBtn);
        make.width.mas_equalTo(tiktokLoginBtn);
        make.height.mas_equalTo(tiktokLoginBtn);
    }];

    UIButton *moreLoginType = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreLoginType setImage:[UIImage imageNamed:@"more_sdk_login"] forState:UIControlStateNormal];
    [self addSubview:moreLoginType];

    [moreLoginType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(systemVersion >= 13.0 ? appleLogin.mas_right : tiktokLoginBtn.mas_right).offset(10);
        make.bottom.mas_equalTo(tiktokLoginBtn);
        make.width.height.mas_equalTo(tiktokLoginBtn);
    }];
    [moreLoginType addTarget:self action:@selector(moreLoginHandle:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -- 点击事件

-(void)moreLoginHandle:(UIButton *)sender{
    [self addSubview:self.otherView];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.otherView.frame;
        rect.origin.y -= self.otherView.bounds.size.height;
        self.otherView.frame = rect;
    }];
}

-(void)closeHandle:(UIButton *)sender{
    if(sender){
        [self hide];
    }
}

-(void)show{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

-(void)hide{
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)countryCodeHandle:(UIButton *)sender{
    countryCodeView *view = [[countryCodeView alloc]init];
    view.didSelectCallback = ^(NSString * _Nonnull text) {
        [self->_countryCodeBtn setTitle:[NSString stringWithFormat:@"+%@",text] forState:UIControlStateNormal];
    };
    [self addSubview:view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

#pragma mark -- lazy load
-(otherLoginTypeView *)otherView{
    if(!_otherView){
        _otherView = [[otherLoginTypeView alloc]init];
        _otherView.backgroundColor = [UIColor whiteColor];
    }
    return _otherView;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
