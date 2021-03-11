//
//  homeContentNewsTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeContentNewsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "TT_TimeIntervalConverString.h"

@interface homeContentNewsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *NewsTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *NewsInfoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *NewsImgView;

@property (weak, nonatomic) IBOutlet UIButton *NewsDelBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NewsImgViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NewsBtnWithImageSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NewsTitleLabelWithImageSpace;

@end

static CGFloat itemSpace = 5;
@implementation homeContentNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setNewsSummaryModel:(homeNewsSummaryModel *)newsSummaryModel{
    _newsSummaryModel = newsSummaryModel;
    
    _NewsTitleLabel.text = newsSummaryModel.infoModel.title;
    [_NewsImgView sd_setImageWithURL:[NSURL URLWithString:newsSummaryModel.infoModel.middle_image.url]];
    
    if (newsSummaryModel.infoModel.middle_image) {
        CGFloat width = (kScreenWidth - 2 * itemSpace) / 3.0;
        _NewsImgView.hidden = NO;
        _NewsImgViewWidth.constant = width;
        _NewsTitleLabelWithImageSpace.constant  = -5;
        _NewsBtnWithImageSpace.constant = -5;
    }else {
        _NewsImgViewWidth.constant = 0;
        _NewsTitleLabelWithImageSpace.constant  = 0;
        _NewsBtnWithImageSpace.constant = 0;
        _NewsImgView.hidden = YES;
    }
    NSString *publish_time = [NSString stringWithFormat:@"%@",[TT_TimeIntervalConverString TT_converTimeIntervalToString:_newsSummaryModel.infoModel.publish_time]];
    _NewsInfoLabel.text = [NSString stringWithFormat:@"%@   %d评论 %@",newsSummaryModel.infoModel.media_name,newsSummaryModel.infoModel.comment_count,publish_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
