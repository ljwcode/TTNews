//
//  shortVideoPlayerViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/10.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "shortVideoPlayerViewCell.h"
#import "videoPlayerToolView.h"
#import <UIImageView+WebCache.h>
#import "UIImage+cropPicture.h"

@interface shortVideoPlayerViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *shortVideoBgImgView;

@property (weak, nonatomic) IBOutlet UILabel *shortVideoTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *shortVideoPlayBtn;

@property (weak, nonatomic) IBOutlet UILabel *shortVideoTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortVideoPlayCount;


@property (weak, nonatomic) IBOutlet UIButton *shortVideoMoreBtn;

@property (weak, nonatomic) IBOutlet UIButton *shortVideoFocusBtn;

@property (weak, nonatomic) IBOutlet UIButton *shortVideoCommitRepeatBtn;

@property (weak, nonatomic) IBOutlet UILabel *shortVideoInfoLabel;


@property (weak, nonatomic) IBOutlet UIButton *shortVideoAuthorHeadImgBtn;


@end

@implementation shortVideoPlayerViewCell

-(void)awakeFromNib{
    [super awakeFromNib];

}

-(void)setContentModel:(videoContentModel *)contentModel{
    _contentModel = contentModel;
    [_shortVideoBgImgView sd_setImageWithURL:[NSURL URLWithString:contentModel.detailModel.playInfoModel.poster_url]];
    _shortVideoInfoLabel.text = contentModel.detailModel.media_name;
    _shortVideoTitleLabel.text = contentModel.detailModel.title;
    [_shortVideoAuthorHeadImgBtn.imageView sd_setImageWithURL:[NSURL URLWithString: contentModel.detailModel.userInfoModel.avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            self->_shortVideoAuthorHeadImgBtn.imageView.image = [image cropPictureWithRoundedCorner:self->_shortVideoAuthorHeadImgBtn.imageView.image.size.width/2 size:self->_shortVideoAuthorHeadImgBtn.frame.size];
        }
    }];
    _shortVideoPlayCount.text = @"20W";
    _shortVideoTimeLabel.text = @"20:20";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
