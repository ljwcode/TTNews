//
//  newsDetailFooterView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/5.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "newsDetailFooterView.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@interface newsDetailFooterView()<UITextFieldDelegate,UITextViewDelegate>

@property(nonatomic,weak)UITextField *discussTextField;

@property(nonatomic,weak)UIButton *repeatBtn;

@property(nonatomic,weak)UIButton *likeBtn;

@property(nonatomic,weak)UIButton *collectionBtn;

@property(nonatomic,weak)UIButton *transmitBtn;

@end

@implementation newsDetailFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        [self.discussTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(vSpace/2);
            make.right.mas_equalTo(hSpace);
            make.height.mas_equalTo(self.height * 0.3);
        }];
        self.discussTextField.layer.borderColor = [UIColor redColor].CGColor;
        self.discussTextField.layer.borderWidth = 2.f;
        
        [self.repeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.discussTextField.width/5);
            make.height.mas_equalTo(self.discussTextField.height);
            make.top.mas_equalTo(self.discussTextField);
            make.bottom.mas_equalTo(self.discussTextField);
            make.left.mas_equalTo(self.discussTextField.mas_right).offset(2 * hSpace);
        }];
        self.repeatBtn.layer.borderColor = [UIColor blueColor].CGColor;
        self.repeatBtn.layer.borderWidth = 2.f;

        [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.repeatBtn.mas_right).offset(2 * hSpace);
            make.top.mas_equalTo(self.discussTextField);
            make.bottom.mas_equalTo(self.discussTextField);
            make.width.height.mas_equalTo(self.repeatBtn);
        }];
        self.collectionBtn.layer.borderColor = [UIColor yellowColor].CGColor;
        self.collectionBtn.layer.borderWidth = 2.f;

        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.collectionBtn.mas_right).offset(2 * hSpace);
            make.top.mas_equalTo(self.collectionBtn);
            make.bottom.mas_equalTo(self.collectionBtn);
            make.width.height.mas_equalTo(self.repeatBtn);
        }];

        self.likeBtn.layer.borderColor = [UIColor purpleColor].CGColor;
        self.likeBtn.layer.borderWidth = 2.f;

        [self.transmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.likeBtn.mas_right).offset(2 * hSpace);
            make.right.mas_equalTo(hSpace);
            make.top.mas_equalTo(self.likeBtn);
            make.bottom.mas_equalTo(self.likeBtn);
            make.width.height.mas_equalTo(self.repeatBtn);
        }];

        self.transmitBtn.layer.borderColor = [UIColor greenColor].CGColor;
        self.transmitBtn.layer.borderWidth = 2.f;
    }
    return self;
}

-(UITextField *)discussTextField{
    if(!_discussTextField){
        UITextField *textfield = [[UITextField alloc]init];
        textfield.delegate = self;
        NSString *text = @"写评论...";
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
        NSTextAttachment *imageAtta = [[NSTextAttachment alloc] init];
        imageAtta.bounds = CGRectMake(0, 0, 21, 21);
        imageAtta.image = [UIImage imageNamed:@"hts_vp_write_new"];
        NSAttributedString *attach = [NSAttributedString attributedStringWithAttachment:imageAtta];
        [attr insertAttributedString:attach atIndex:0];
        textfield.attributedPlaceholder = attr;
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        textfield.layer.cornerRadius = 15.f;
        [textfield addTarget:self action:@selector(discussHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:textfield];
        _discussTextField = textfield;
    }
    return _discussTextField;
}

-(UIButton *)repeatBtn{
    if(!_repeatBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"comment_live_day"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(repeatHnadle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _repeatBtn = btn;
    }
    return _repeatBtn;
}

-(UIButton *)collectionBtn{
    if(!_collectionBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_details_collect"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_details_collect_press"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(collectionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _collectionBtn = btn;
    }
    return _collectionBtn;
}

-(UIButton *)likeBtn{
    if(!_likeBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"details_like_icon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"details_like_icon_press"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(likeHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _likeBtn = btn;
    }
    return _likeBtn;
}

-(UIButton *)transmitBtn{
    if(!_transmitBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_share_tabbar"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_share_tabbar_press"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(transmitHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _transmitBtn = btn;
    }
    return _transmitBtn;
}

#pragma mark - 点击响应事件

-(void)repeatHnadle:(UIButton *)sender{
    
}

-(void)discussHandle:(UIButton *)sender{
    
}

-(void)collectionHandle:(UIButton *)sender{
    
}

-(void)likeHandle:(UIButton *)sender{
    
}

-(void)transmitHandle:(UIButton *)sender{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
