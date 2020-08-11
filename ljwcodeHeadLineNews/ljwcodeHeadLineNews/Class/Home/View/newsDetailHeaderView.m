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
#import <UIImageView+WebCache.h>
#import "UIImage+cropPicture.h"

@interface newsDetailHeaderView()

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,weak)UIButton *headImgBtn;

@property(nonatomic,weak)UIButton *authorNameBtn;

@property(nonatomic,weak)UILabel *authorDetailLabel;

@property(nonatomic,weak)UIButton *focusBtn;

@end

@implementation newsDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        NSLog(@"高度 = %f,宽度 = %f",self.height,self.width);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(vSpace);
//            make.right.mas_equalTo(hSpace);
            make.width.mas_equalTo(self.width - 2 * hSpace);
            make.height.mas_equalTo(self.height * 0.5);
        }];
        
        self.titleLabel.layer.borderColor = [UIColor systemPinkColor].CGColor;
        self.titleLabel.layer.borderWidth = 2.f;
        [self.headImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(2 * vSpace);
            make.bottom.mas_equalTo(vSpace);
            make.width.height.mas_equalTo(30);
        }];

        [self.authorNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImgBtn.mas_right).offset(hSpace/2);
            make.top.mas_equalTo(self.headImgBtn);
            make.height.mas_equalTo(self.headImgBtn.height * 0.5);
        }];

        [self.authorDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.authorNameBtn);
            make.top.mas_equalTo(self.authorNameBtn.mas_bottom).offset(2);
            make.bottom.mas_equalTo(vSpace);
            make.height.mas_equalTo(self.headImgBtn.height * 0.5 - 2);
        }];

        [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headImgBtn);
            make.right.mas_equalTo(hSpace);
            make.height.mas_equalTo(self.authorNameBtn.height + self.authorDetailLabel.height);
            make.left.mas_lessThanOrEqualTo(self.authorNameBtn.mas_right).offset(2 * hSpace);
            make.left.mas_lessThanOrEqualTo(self.authorDetailLabel.mas_right).offset(2 *hSpace);
            /*
             1 1 1
             */
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
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
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
        [btn setTitle:@"关注" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:btn];
        _focusBtn = btn;
    }
    return _focusBtn;
}

#pragma mark - 设置数据源

-(void)setHeadViewDataSource{
    self.titleLabel.text = _articleTitle;
    [self.headImgBtn.imageView sd_setImageWithURL:[NSURL URLWithString:_authorHeadImgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.headImgBtn.imageView.image = [image cropPictureWithRoundedCorner:self.headImgBtn.imageView.image.size.width/2 size:self.headImgBtn.frame.size];
    }];
    [self.authorNameBtn setTitle:_authorName forState:UIControlStateNormal];
    self.authorDetailLabel.text = _authorAbstract;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
