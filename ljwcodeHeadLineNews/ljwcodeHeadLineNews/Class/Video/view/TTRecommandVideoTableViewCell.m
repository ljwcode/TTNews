//
//  TTRecommandVideoTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTRecommandVideoTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface TTRecommandVideoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *TT_VideoTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *TT_VideoInfoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *TT_VideoCoverImgView;

@property (weak, nonatomic) IBOutlet UILabel *TT_VideoTimeLabel;


@end

@implementation TTRecommandVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDetailModel:(TT_VideoDetailModel *)detailModel{
    _detailModel = detailModel;
    self.TT_VideoTitleLabel.text = detailModel.related_video_toutiao.title;
    self.TT_VideoInfoLabel.text = detailModel.related_video_toutiao.media_name;
    [self.TT_VideoCoverImgView sd_setImageWithURL:[NSURL URLWithString:detailModel.related_video_toutiao.video_detail_info.detail_video_large_image.url]];
    self.TT_VideoTimeLabel.text = [NSString stringWithFormat:@"%d:%d",detailModel.related_video_toutiao.video_duration/60,detailModel.related_video_toutiao.video_duration%60];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
