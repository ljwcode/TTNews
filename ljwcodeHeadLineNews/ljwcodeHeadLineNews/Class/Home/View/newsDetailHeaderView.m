//
//  newsDetailHeaderView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "newsDetailHeaderView.h"
#import <UIView+Frame.h>
#import <Masonry/Masonry.h>

@interface newsDetailHeaderView()

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,weak)UIButton *headImgBtn;

@property(nonatomic,weak)UIButton *authorNameBtn;

@property(nonatomic,weak)UILabel *authorDetailLabel;

@property(nonatomic,weak)UIButton *focusBtn;

@end

static CGFloat hSpace = 10;
static CGFloat vSpace = 10;
@implementation newsDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(vSpace);
            make.right.mas_equalTo(hSpace);
        }];
        
        [self.headImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(2 * vSpace);
            make.bottom.mas_equalTo(vSpace);
            make.width.height.mas_equalTo(30);
        }];
        
        
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:22.f];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

-(UIButton *)headImgBtn{
    if(!_headImgBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:btn];
        _headImgBtn = btn;
    }
    return _headImgBtn;
}

-(UIButton *)authorNameBtn{
    if(!_authorNameBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:btn];
        _authorNameBtn = btn;
    }
    return _authorNameBtn;
}

-(UILabel *)authorDetailLabel{
    if(!_authorDetailLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:11.f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _authorDetailLabel = label;
    }
    return _authorDetailLabel;
}

-(UIButton *)focusBtn{
    if(!_focusBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:btn];
        _focusBtn = btn;
    }
    return _focusBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
