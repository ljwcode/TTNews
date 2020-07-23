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

@interface TVVideoPlayerViewCell()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *videoBgImgView;

@property (weak, nonatomic) IBOutlet UILabel *vodeoTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *videoPlayBtn;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoPlayCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *videoDetailImgView;

@property (weak, nonatomic) IBOutlet UIButton *videoAuthHeadImgBtn;

@property (weak, nonatomic) IBOutlet UILabel *videoAuthorTitleLabel;


@property (weak, nonatomic) IBOutlet UIButton *videoFocusBtn;

@property (weak, nonatomic) IBOutlet UIButton *videoCommitRepeatBtn;

@property (weak, nonatomic) IBOutlet UIButton *videoMoreBtn;

@end

//点击播放 在表页面播放 点击全屏，进入全屏播放
@implementation TVVideoPlayerViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _videoBgImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapBgView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapVideoPlayHandle:)];
    [_videoBgImgView addGestureRecognizer:tapBgView];
    
    [_videoPlayBtn addTarget:self action:@selector(tapVideoPlayHandle:) forControlEvents:UIControlEventTouchUpInside];
    [_videoBgImgView addSubview:_videoPlayBtn];
    [_videoBgImgView addSubview:_vodeoTitleLabel];
    [_videoBgImgView addSubview:_videoTimeLabel];
    [_videoBgImgView addSubview:_videoPlayCountLabel];
    
    _videoDetailImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapDetailView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapVideoDetailHandle:)];
    [_videoDetailImgView addGestureRecognizer:tapDetailView];
    
    [_videoAuthHeadImgBtn addTarget:self action:@selector(videoAuthorInfoHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    [_videoFocusBtn addTarget:self action:@selector(focusHandle:) forControlEvents:UIControlEventTouchUpInside];
    [_videoCommitRepeatBtn addTarget:self action:@selector(repeatHandle:) forControlEvents:UIControlEventTouchUpInside];
    [_videoMoreBtn addTarget:self action:@selector(moreHandle:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)focusHandle:(UIButton *)sender{
    
}

-(void)repeatHandle:(UIButton *)sender{
    
}

-(void)moreHandle:(UIButton *)sender{
    
}

-(void)videoAuthorInfoHandle:(UIButton *)sender{
    
}

-(void)tapVideoPlayHandle:(id)sender{
    
}

-(void)tapVideoDetailHandle:(UITapGestureRecognizer *)tap{
    
}

-(void)setContentModel:(videoContentModel *)contentModel{
    _contentModel = contentModel;
    [_videoBgImgView sd_setImageWithURL:[NSURL URLWithString:contentModel.detailModel.playInfoModel.poster_url]];
    _videoAuthorTitleLabel.text = contentModel.detailModel.media_name;
    _vodeoTitleLabel.text = contentModel.detailModel.title;
    [_videoAuthHeadImgBtn.imageView sd_setImageWithURL:[NSURL URLWithString: contentModel.detailModel.userInfoModel.avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            self->_videoAuthHeadImgBtn.imageView.image = [image cropPictureWithRoundedCorner:self->_videoAuthHeadImgBtn.imageView.image.size.width/2 size:self->_videoAuthHeadImgBtn.frame.size];
        }
    }];
    _videoPlayCountLabel.text = @"20W";
    _videoTimeLabel.text = @"20:20";
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
