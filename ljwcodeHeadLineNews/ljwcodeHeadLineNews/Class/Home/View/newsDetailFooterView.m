//
//  newsDetailFooterView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/5.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "newsDetailFooterView.h"

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
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(self.mas_bottom).offset(TT_isIphoneX ? -39 : -15);
            make.width.mas_equalTo(kScreenWidth * 0.4);
        }];
        
        [self.repeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.discussTextField);
            make.width.mas_equalTo(kScreenWidth * 0.1);
            make.top.mas_equalTo(self.discussTextField);
            make.bottom.mas_equalTo(self.discussTextField);
            make.left.mas_equalTo(self.discussTextField.mas_right).offset(1 * hSpace);
        }];
      
        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.repeatBtn);
            make.left.mas_equalTo(self.repeatBtn.mas_right).offset(1 * hSpace);
            make.top.mas_equalTo(self.discussTextField);
        }];
        
        [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.likeBtn);
            make.left.mas_equalTo(self.likeBtn.mas_right).offset(1 * hSpace);
            make.top.mas_equalTo(self.discussTextField);
        }];
        
        [self.transmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.collectionBtn);
            make.left.mas_equalTo(self.collectionBtn.mas_right).offset(1 * hSpace);
            make.top.mas_equalTo(self.discussTextField);
            make.right.mas_lessThanOrEqualTo(hSpace);
        }];

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
        textfield.layer.cornerRadius = 20.f;
        textfield.layer.masksToBounds = YES;
        textfield.layer.borderColor = [UIColor grayColor].CGColor;
        textfield.layer.borderWidth = 0.5f;
        [textfield addTarget:self action:@selector(discussHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:textfield];
        _discussTextField = textfield;
    }
    return _discussTextField;
}

-(UIButton *)repeatBtn{
    if(!_repeatBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"comment_live_day"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(repeatHnadle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _repeatBtn = btn;
    }
    return _repeatBtn;
}

-(UIButton *)collectionBtn{
    if(!_collectionBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tab_collect"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_details_collect_press"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(collectionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _collectionBtn = btn;
    }
    return _collectionBtn;
}

-(UIButton *)likeBtn{
    if(!_likeBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"details_like_icon"] forState:UIControlStateNormal];
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
        [btn setImage:[UIImage imageNamed:@"tab_share3"] forState:UIControlStateNormal];
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
