//
//  homeContentNewsTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeContentNewsTableViewCell.h"
#import <UIImageView+WebCache.h>

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
    _NewsInfoLabel.text = [NSString stringWithFormat:@"%@   %d阅读  0分钟前",newsSummaryModel.infoModel.media_name,newsSummaryModel.infoModel.read_count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
