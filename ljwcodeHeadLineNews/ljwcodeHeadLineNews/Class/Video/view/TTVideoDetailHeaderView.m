//
//  TTVideoDetailHeaderView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTVideoDetailHeaderView.h"
#import <Masonry/Masonry.h>
#import "UILabel+Frame.h"
#import "UIImage+cropPicture.h"
#import <UIImageView+WebCache.h>

@interface TTVideoDetailHeaderView()

@property(nonatomic,strong)UIImageView *headImgView;

@property(nonatomic,strong)UILabel *authorNameLabel;

@property(nonatomic,strong)UILabel *fansNumLabel;

@property(nonatomic,strong)UIButton *focusBtn;

@end

@implementation TTVideoDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.headImgView];
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.centerY.mas_equalTo(self);
            make.height.width.mas_equalTo(CGRectGetHeight(self.frame)*2/3);
        }];
        
        UIView *authorView = [[UIView alloc]init];
        [self addSubview:authorView];
        [authorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(self.headImgView);
            make.width.mas_equalTo(kScreenWidth * 0.4);
        }];
        
        [authorView addSubview:self.authorNameLabel];
        [self.authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImgView.mas_right).offset(hSpace/2);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(CGRectGetHeight(authorView.frame)/2-5);
            make.width.mas_equalTo(kScreenWidth * 0.4);
        }];
        
        [authorView addSubview:self.fansNumLabel];
        [self.fansNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImgView.mas_right).offset(hSpace/2);
            make.top.mas_equalTo(self.authorNameLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(self.authorNameLabel);
            make.width.mas_equalTo(kScreenWidth * 0.4);
            make.bottom.mas_equalTo(0);
        }];
        
        [self addSubview:self.focusBtn];
        [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-hSpace);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(self.headImgView);
            make.width.mas_equalTo(kScreenWidth * 0.2);
        }];
    }
    return self;
}

-(void)setDetailModel:(TT_VideoDetailModel *)detailModel{
    _detailModel = detailModel;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:detailModel.user_info.avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            self.headImgView.image = [image cropPictureWithRoundedCorner:self.headImgView.image.size.width size:self.headImgView.frame.size];
        }
    }];
    self.authorNameLabel.text = detailModel.user_info.name;
    self.fansNumLabel.text = [NSString stringWithFormat:@"%@粉丝",detailModel.user_info.fans_count];
}

#pragma mark ----- lazy load

-(UIImageView *)headImgView{
    if(!_headImgView){
        _headImgView = [[UIImageView alloc]init];
    }
    return _headImgView;
}

-(UILabel *)authorNameLabel{
    if(!_authorNameLabel){
        _authorNameLabel = [[UILabel alloc]init];
        _authorNameLabel.textColor = [UIColor blackColor];
        _authorNameLabel.textAlignment = NSTextAlignmentLeft;
        _authorNameLabel.font = [UIFont systemFontOfSize:15.f];
        [_authorNameLabel TTContentFitWidth];
        [_authorNameLabel TTContentFitHeight];
    }
    return _authorNameLabel;
}

-(UILabel *)fansNumLabel{
    if(!_fansNumLabel){
        _fansNumLabel = [[UILabel alloc]init];
        _fansNumLabel.textColor = [UIColor blackColor];
        _fansNumLabel.textAlignment = NSTextAlignmentLeft;
        _fansNumLabel.font = [UIFont systemFontOfSize:10.f];
        [_fansNumLabel TTContentFitHeight];
        [_fansNumLabel TTContentFitWidth];
    }
    return _fansNumLabel;
}

-(UIButton *)focusBtn{
    if(!_focusBtn){
        _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_focusBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [_focusBtn setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:85.0/255.0 blue:86.0/255.0 alpha:1]];
        _focusBtn.titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
        [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        _focusBtn.layer.cornerRadius = 3.f;
        [_focusBtn.titleLabel TTContentFitWidth];
        [_focusBtn.titleLabel TTContentFitHeight];
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
