//
//  TTRecommandVideoTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTRecommandVideoTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIImage+cropPicture.h"

@interface TTRecommandVideoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *XG_HeadImgView;

@property (weak, nonatomic) IBOutlet UILabel *XG_AuthorNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *XG_VImgView;

@property (weak, nonatomic) IBOutlet UIButton *XG_DelBtn;

@property (weak, nonatomic) IBOutlet UILabel *XG_VideoInfoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *XG_VideoConverImgView;

@property (weak, nonatomic) IBOutlet UILabel *XG_VideoTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *XG_VideoNumLabel;


@end

@implementation TTRecommandVideoTableViewCell

- (void)awakeFromNib {
    self.XG_VideoTimeLabel.layer.cornerRadius = 8.f;
    self.XG_VideoTimeLabel.layer.masksToBounds = YES;
    self.XG_VideoTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.XG_VideoNumLabel.textAlignment = NSTextAlignmentCenter;
    [super awakeFromNib];
    // Initialization code
}

-(void)setContentModel:(videoContentModel *)contentModel{
    _contentModel = contentModel;
    [self.XG_HeadImgView sd_setImageWithURL:[NSURL URLWithString:contentModel.detailModel.media_info.avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            self.XG_HeadImgView.image = [image cropPictureWithRoundedCorner:self.XG_HeadImgView.image.size.width size:self.XG_HeadImgView.frame.size];
        }
    }];
    
    self.XG_AuthorNameLabel.text = contentModel.detailModel.media_info.name;
    self.XG_VideoInfoLabel.text = contentModel.detailModel.title;
    [self.XG_VideoConverImgView sd_setImageWithURL:[NSURL URLWithString:contentModel.detailModel.video_detail_info.detail_video_large_image.url]];
    self.XG_VideoNumLabel.text = [NSString stringWithFormat:@"%d次播放",contentModel.detailModel.video_detail_info.video_watch_count];
    self.XG_VideoTimeLabel.text = [NSString stringWithFormat:@"%d:%d",contentModel.detailModel.video_duration/60,contentModel.detailModel.video_duration%60];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
