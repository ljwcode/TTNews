//
//  TTRecommandVideoTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTRecommandVideoTableViewCell.h"

@interface TTRecommandVideoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *TT_VideoTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *TT_VideoInfoLabel;


@property (weak, nonatomic) IBOutlet UIImageView *TT_VideoCoverImgView;

@end

@implementation TTRecommandVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
