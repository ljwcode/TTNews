//
//  TVVideoPlayerViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TVVideoPlayerViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIImage+cropPicture.h"
#import <SDWebImageManager.h>
#import "UILabel+Frame.h"

@interface TVVideoPlayerViewCell()<UIGestureRecognizerDelegate>

@property (weak, nonatomic)UIImageView *videoBgImgView;

@property (weak, nonatomic)UILabel *videoTitleLabel;

@property (weak, nonatomic)UIButton *videoPlayBtn;

@property (weak, nonatomic)UILabel *videoTimeLabel;

@property (weak, nonatomic)UILabel *videoPlayCountLabel;

@property(nonatomic,weak)UIView *authorBgView;

@property (weak, nonatomic)UIButton *videoAuthHeadBtn;

@property (weak, nonatomic)UIButton *authorFocusBtn;

@property (weak, nonatomic)UIButton *videoMoreBtn;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)UIImageView *authHeadImgView;

@end

@implementation TVVideoPlayerViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self.videoBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(125);
        }];
        
        [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.centerX.mas_equalTo(self.contentView);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(125);
        }];
        
        [self.videoPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.videoBgImgView);
            make.width.height.mas_equalTo(60);
        }];
        
        [self.videoPlayCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace/2);
            make.bottom.mas_equalTo(self.videoBgImgView.mas_bottom).offset(-hSpace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        [self.videoTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-hSpace/2);
            make.bottom.mas_equalTo(self.videoBgImgView.mas_bottom).offset(-hSpace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        [self.authorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.videoBgImgView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPushHandle:)];
        [self.authorBgView addGestureRecognizer:tapGes];
        
        [self.authorBgView addSubview:self.authHeadImgView];
        [self.authHeadImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.centerY.mas_equalTo(self.authorBgView);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.videoAuthHeadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.authHeadImgView.mas_right).offset(2);;
            make.centerY.mas_equalTo(self.authorBgView);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(80);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.authorBgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.videoAuthHeadBtn.mas_right).offset(hSpace/2);
            make.width.mas_equalTo(1);
            make.centerY.mas_equalTo(self.authorBgView);
            make.height.mas_equalTo(10);
        }];
        
        [self.authorFocusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineView.mas_right).offset(hSpace/2);
            make.centerY.mas_equalTo(self.authorBgView);
            make.height.width.mas_equalTo(40);
        }];
        
        [self.videoCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_lessThanOrEqualTo(self.authorFocusBtn.mas_right).offset(5 * hSpace);
            make.centerY.mas_equalTo(self.authorFocusBtn);
            make.height.mas_equalTo(self.authorFocusBtn);
            make.width.mas_equalTo(40 * 1.5);
        }];
        
        [self.videoMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-hSpace);
            make.left.mas_equalTo(self.videoCommentBtn.mas_right).offset(hSpace);
            make.centerY.mas_equalTo(self.authorBgView);
            make.height.width.mas_equalTo(self.authorFocusBtn);
        }];
        
    }
    return self;
}

#pragma mark -- set model
-(void)setContentModel:(videoContentModel *)contentModel{
    _contentModel = contentModel;
    [self.videoBgImgView sd_setImageWithURL:[NSURL URLWithString:contentModel.detailModel.video_detail_info.detail_video_large_image.url]];
    [self.videoAuthHeadBtn setTitle:contentModel.detailModel.media_name forState:UIControlStateNormal];
    self.videoTitleLabel.text = contentModel.detailModel.title;
    
    NSString * urlStr = [contentModel.detailModel.media_info.avatar_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if(urlStr){
        [self.authHeadImgView sd_setImageWithURL:[NSURL URLWithString:urlStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(!image){
                [self.authHeadImgView setImage:[UIImage imageNamed:@"recommend_user_see_more_icon"]];
            }else{
                self.authHeadImgView.image = [image cropPictureWithRoundedCorner:self.authHeadImgView.image.size.width/2 size:self.authHeadImgView.frame.size];
            }
        }];
    }else{
        [self.authHeadImgView setImage:[UIImage imageNamed:@"recommend_user_see_more_icon"]];
    }
    
    self.videoPlayCountLabel.text = [NSString stringWithFormat:@"%d次播放",contentModel.detailModel.video_detail_info.video_watch_count];
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%d:%d",contentModel.detailModel.video_duration/60,contentModel.detailModel.video_duration%60];
    self.videoFrame = CGRectMake(0, 0, kScreenWidth,175);
    [self.videoCommentBtn setTitle:contentModel.detailModel.comment_count forState:UIControlStateNormal];
}


#pragma mark -- lzay load

-(UIImageView *)videoBgImgView{
    if(!_videoBgImgView){
        UIImageView *imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:imgView];
        _videoBgImgView = imgView;
    }
    return _videoBgImgView;
}

-(UILabel *)videoTitleLabel{
    if(!_videoTitleLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:25.f weight:6.f];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _videoTitleLabel = label;
    }
    return _videoTitleLabel;
}

-(UIButton *)videoPlayBtn{
    if(!_videoPlayBtn){
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"toutiaovideo"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickPlayHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.videoBgImgView addSubview:btn];
        _videoPlayBtn = btn;
    }
    return _videoPlayBtn;
}

-(UILabel *)videoPlayCountLabel{
    if(!_videoPlayCountLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12.f];
        label.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:label];
        _videoPlayCountLabel = label;
    }
    return _videoPlayCountLabel;
}

-(UILabel *)videoTimeLabel{
    if(!_videoTimeLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10.f];
        label.backgroundColor = [UIColor blackColor];
        label.layer.cornerRadius = 10.f;
        label.layer.masksToBounds = YES;
        label.alpha = 0.6;
        [self.contentView addSubview:label];
        _videoTimeLabel = label;
    }
    return _videoTimeLabel;
}

-(UIView *)authorBgView{
    if(!_authorBgView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _authorBgView = view;
    }
    return _authorBgView;
}

-(UIButton *)videoAuthHeadBtn{
    if(!_videoAuthHeadBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.authorBgView addSubview:btn];
        _videoAuthHeadBtn = btn;
    }
    return _videoAuthHeadBtn;
}

-(UIButton *)authorFocusBtn{
    if(!_authorFocusBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"关注" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
        [btn addTarget:self action:@selector(focusHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.authorBgView addSubview:btn];
        _authorFocusBtn = btn;
    }
    return _authorFocusBtn;
}

-(UIButton *)videoCommentBtn{
    if(!_videoCommentBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tab_comment"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [btn addTarget:self action:@selector(commentHandle:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel TTContentFitWidth];
        [btn.titleLabel TTContentFitHeight];
        [self.authorBgView addSubview:btn];
        _videoCommentBtn = btn;
    }
    return _videoCommentBtn;
}

-(UIButton *)videoMoreBtn{
    if(!_videoMoreBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"new_more_titlebar"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.authorBgView addSubview:btn];
        _videoMoreBtn = btn;
    }
    return _videoMoreBtn;
}

-(UIImageView *)authHeadImgView{
    if(!_authHeadImgView){
        _authHeadImgView = [[UIImageView alloc]init];
    }
    return _authHeadImgView;
}

-(void)setDelegate:(id<TVVideoPlayerCellDelegate,NSObject>)delegate withIndexPath:(NSIndexPath *)indexPath{
    self.delegate = delegate;
    self.indexPath = indexPath;
}

#pragma mark -- 点击事件响应
-(void)clickPlayHandle:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(initPlayerView:playClick:)]){
        [self.delegate initPlayerView:self playClick:self.contentModel];
    }
}

-(void)focusHandle:(UIButton *)sender{
    
}

-(void)commentHandle:(UIButton *)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(TT_commentDetail:)]){
        [self.delegate TT_commentDetail:self.contentModel];
    }
}

-(void)moreHandle:(UIButton *)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(TT_moreHandle)]){
        [self.delegate TT_moreHandle];
    }
}

-(void)setNormalModel{
    self.videoBgImgView.hidden = YES;
}

-(void)tapPushHandle:(UITapGestureRecognizer *)tap{
    if(self.delegate && [self.delegate respondsToSelector:@selector(TT_TapPushHandle:)]){
        [self.delegate TT_TapPushHandle:self.contentModel];
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
