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


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (weak, nonatomic) IBOutlet UIImageView *detailImgView;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailImgViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailImgSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailLabelSpace;


@end

static CGFloat itemSpace = 5;
@implementation homeContentNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setNewsSummaryModel:(homeNewsSummaryModel *)newsSummaryModel{
    _newsSummaryModel = newsSummaryModel;
    
    _titleLabel.text = newsSummaryModel.infoModel.title;
    if (newsSummaryModel.infoModel.middle_image) {
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 20 - 2 * itemSpace) / 3.0;
        _detailImgView.hidden = NO;
        [_detailImgView sd_setImageWithURL:[NSURL URLWithString:newsSummaryModel.infoModel.middle_image.url]];
        _detailImgViewWidth.constant = width;
        _detailLabelSpace.constant  = 8;
        _detailImgSpace.constant = 12;
    }else {
        _detailImgViewWidth.constant = 0;
        _detailLabelSpace.constant  = 0;
        _detailImgSpace.constant = 0;
        _detailImgView.hidden = YES;
    }
    _detailLabel.text = [NSString stringWithFormat:@"%@   %d阅读  0分钟前",newsSummaryModel.infoModel.media_name,newsSummaryModel.infoModel.read_count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
