//
//  TT_UserCommentTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_UserCommentTableViewCell.h"

@interface TT_UserCommentTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *TT_HeadImgView;

@property (weak, nonatomic) IBOutlet UILabel *TT_UserNameLabel;

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
