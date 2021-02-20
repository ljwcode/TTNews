//
//  TTVideoDetailView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/1.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTVideoDetailView.h"
#import <Masonry/Masonry.h>
#import "UILabel+Frame.h"

@interface TTVideoDetailView()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIButton *openUpBtn;

@property(nonatomic,strong)UILabel *authorVideoInfoLabel;

@property(nonatomic,strong)UILabel *videoInfoLabel;

@property(nonatomic,strong)NSArray *imgArray;

@end

@implementation TTVideoDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.right.mas_equalTo(-4 * hSpace);
            make.top.mas_equalTo(vSpace);
            make.height.mas_greaterThanOrEqualTo(2 * vSpace);
        }];
        
        [self addSubview:self.openUpBtn];
        [self.openUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(hSpace);
            make.right.mas_equalTo(-hSpace);
            make.width.height.mas_equalTo(hSpace);
            make.top.mas_equalTo(vSpace);
        }];
        
        [self addSubview:self.authorVideoInfoLabel];
        [self.authorVideoInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(vSpace);
            make.height.mas_equalTo(vSpace);
            make.width.mas_equalTo(kScreenWidth * 0.4);
        }];
        
        [self addSubview:self.videoInfoLabel];
        [self.videoInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(self.authorVideoInfoLabel.mas_bottom).offset(vSpace);
            make.height.width.mas_equalTo(self.authorVideoInfoLabel);
        }];
        
        for(int i = 0;i < self.imgArray.count;i++){
            UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            actionBtn.titleLabel.font = [UIFont systemFontOfSize:10.f];
            [actionBtn setTag:i];
            [actionBtn setImage:[UIImage imageNamed:self.imgArray[i]] forState:UIControlStateNormal];
            actionBtn.layer.cornerRadius = 8.f;
            actionBtn.layer.masksToBounds = YES;
            [self addSubview:actionBtn];
            actionBtn.layer.borderColor = [UIColor grayColor].CGColor;
            actionBtn.layer.borderWidth = 0.5f;
            [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace + (i * (kScreenWidth - 3 * hSpace)/3 + hSpace));
                make.width.mas_equalTo((kScreenWidth - 4 * hSpace)/3);
                make.top.mas_equalTo(self.videoInfoLabel.mas_bottom).offset(vSpace);
                make.bottom.mas_equalTo(-vSpace);
            }];
        }
    }
    return self;
}

-(void)setDetailModel:(TT_VideoDetailModel *)detailModel{
    _detailModel = detailModel;
    self.titleLabel.text = detailModel.share_info.title;
    self.authorVideoInfoLabel.text = [NSString stringWithFormat:@"%@次观看",detailModel.video_watch_count];
}

#pragma mark ----- lazy load

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel TTContentFitWidth];
        [_titleLabel TTContentFitHeight];
    }
    return _titleLabel;
}

-(UIButton *)openUpBtn{
    if(!_openUpBtn){
        _openUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openUpBtn setImage:[UIImage imageNamed:@"personal_home_recommend_down_black"] forState:UIControlStateNormal];
        [_openUpBtn addTarget:self action:@selector(openUpHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openUpBtn;
}

-(UILabel *)authorVideoInfoLabel{
    if(!_authorVideoInfoLabel){
        _authorVideoInfoLabel = [[UILabel alloc]init];
        _authorVideoInfoLabel.font = [UIFont systemFontOfSize:10.f];
        _authorVideoInfoLabel.textColor = [UIColor lightGrayColor];
        _authorVideoInfoLabel.textAlignment = NSTextAlignmentLeft;
        [_authorVideoInfoLabel TTContentFitWidth];
        [_authorVideoInfoLabel TTContentFitHeight];
    }
    return _authorVideoInfoLabel;
}

-(UILabel *)videoInfoLabel{
    if(!_videoInfoLabel){
        _videoInfoLabel = [[UILabel alloc]init];
        _videoInfoLabel.font = [UIFont systemFontOfSize:10.f];
        _videoInfoLabel.textColor = [UIColor lightGrayColor];
        _videoInfoLabel.textAlignment = NSTextAlignmentCenter;
        [_videoInfoLabel TTContentFitWidth];
        [_videoInfoLabel TTContentFitHeight];
    }
    return _videoInfoLabel;
}

-(NSArray *)imgArray{
    if(!_imgArray){
        _imgArray = @[@"like_grey_comment",@"tab_share1",@"details_admire_icon"];
    }
    return _imgArray;
}

#pragma mark ---- 响应事件

-(void)openUpHandle:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender){
        [sender setImage:[UIImage imageNamed:@"personal_home_recommend_up_black"] forState:UIControlStateSelected];
    }else{
        [sender setImage:[UIImage imageNamed:@"personal_home_recommend_down_black"] forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
