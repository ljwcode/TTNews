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
            make.bottom.mas_equalTo(vSpace);
        }];
        
        [self.repeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo((self.width - 13 * hSpace - self.discussTextField.width) / 3);
            make.top.mas_equalTo(self.discussTextField);
            make.bottom.mas_equalTo(self.discussTextField);
            make.left.mas_equalTo(self.discussTextField.mas_right).offset(2 * hSpace);
        }];
        
        [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.repeatBtn.mas_right).offset(3 * hSpace);
            make.top.mas_equalTo(self.discussTextField);
            make.bottom.mas_equalTo(self.discussTextField);
        }];
        
        // a b c d e
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
        [self addSubview:textfield];
        _discussTextField = textfield;
    }
    return _discussTextField;
}

-(UIButton *)repeatBtn{
    if(!_repeatBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"comment_live_day"] forState:UIControlStateNormal];
        btn.contentMode = UIViewContentModeScaleAspectFit;
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
        btn.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:btn];
        _collectionBtn = btn;
    }
    return _collectionBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
