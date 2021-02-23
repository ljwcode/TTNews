//
//  TT_UserCommentTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_UserCommentTableViewCell.h"
#import "UIImage+cropPicture.h"
#import <UIImageView+WebCache.h>

@interface TT_UserCommentTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *TT_HeadImgView;

@property (weak, nonatomic) IBOutlet UIButton *TT_LikeBtn;

@property (weak, nonatomic) IBOutlet UILabel *TT_UserInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *TT_CommentContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *TT_CommentCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *TT_TimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *TT_DelBtn;

@end

@implementation TT_UserCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCommentModel:(TT_VideoCommentModel *)commentModel{
    _commentModel = commentModel;
    [self.TT_HeadImgView sd_setImageWithURL:[NSURL URLWithString:commentModel.commentDetailModel.user_profile_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            self.TT_HeadImgView.image = [image cropPictureWithRoundedCorner:self.TT_HeadImgView.image.size.width size:self.TT_HeadImgView.frame.size];
        }
    }];
    [self.TT_LikeBtn setTitle:commentModel.commentDetailModel.digg_count forState:UIControlStateNormal];
    self.TT_UserInfoLabel.text = commentModel.commentDetailModel.user_name;
    self.TT_CommentContentLabel.text = commentModel.commentDetailModel.text;
    self.TT_CommentCountLabel.text = [NSString stringWithFormat:@"%@回复",commentModel.commentDetailModel.reply_count];
    self.TT_TimeLabel.text = commentModel.commentDetailModel.create_time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
