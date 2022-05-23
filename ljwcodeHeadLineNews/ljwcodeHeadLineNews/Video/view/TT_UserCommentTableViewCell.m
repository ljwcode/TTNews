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
#import "TT_TimeIntervalConverString.h"
#import "UILabel+Frame.h"

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
    self.TT_CommentCountLabel.layer.cornerRadius = 12.f;
    self.TT_CommentCountLabel.layer.masksToBounds = YES;
    self.TT_CommentCountLabel.textAlignment = NSTextAlignmentCenter;
    self.TT_CommentCountLabel.backgroundColor = TT_ColorWithRed(248, 248, 248, 1);
    
    // Initialization code
}

-(void)setCommentModel:(TT_UserCommentModel *)commentModel{
    _commentModel = commentModel;
    [self.TT_HeadImgView sd_setImageWithURL:[NSURL URLWithString:commentModel.comment.user_profile_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            self.TT_HeadImgView.image = [image cropPictureWithRoundedCorner:self.TT_HeadImgView.image.size.width size:self.TT_HeadImgView.frame.size];
        }
    }];
    if(![commentModel.comment.digg_count isEqualToString:@""]){
        [self.TT_LikeBtn setTitle:commentModel.comment.digg_count forState:UIControlStateNormal];
    }else{
        [self.TT_LikeBtn setTitle:@"赞" forState:UIControlStateNormal];
    }
    self.TT_UserInfoLabel.text = commentModel.comment.user_name;
    self.TT_CommentContentLabel.text = commentModel.comment.text;
    self.TT_CommentCountLabel.text = [NSString stringWithFormat:@"%@回复",commentModel.comment.reply_count];
    self.TT_TimeLabel.text = [TT_TimeIntervalConverString TT_converTimeIntervalToString:commentModel.comment.create_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
