//
//  loginView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "loginView.h"
#import <Masonry/Masonry.h>

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
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
