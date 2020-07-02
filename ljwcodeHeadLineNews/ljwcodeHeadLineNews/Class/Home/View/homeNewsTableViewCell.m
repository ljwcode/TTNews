//
//  homeNewsTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsTableViewCell.h"
#import "ljwcodeHeader.h"

@interface homeNewsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewConstraintWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageViewConstraintHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleImageViewConstraintHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleImageViewConstraintWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewConstraintHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewConstraintWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftToMiddleConstraintMargin;

@property(nonatomic,strong)NSArray *imageViews;


@end

static CGFloat itemSpace = 5;

@implementation homeNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSArray *constraintArray = @[_leftImageViewConstraintWidth,_leftImageViewConstraintHeight,_middleImageViewConstraintWidth,_middleImageViewConstraintHeight,_rightImageViewConstraintWidth,_rightImageViewConstraintHeight];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 20 - 2 * itemSpace)/3;
    for(NSLayoutConstraint *constraint in constraintArray){
        constraint.constant = width;
    }
    _leftToMiddleConstraintMargin.constant = itemSpace;
    _titleLabel.numberOfLines = 2;
    _infoLabel.font = [UIFont systemFontOfSize:10];
    _imageViews = @[_leftImageView,_middleImageView,_rightImageView];
    // Initialization code
}

-(void)setSummaryModel:(homeNewsSummaryModel *)summaryModel{
    _summaryModel = summaryModel;
    _titleLabel.text = _summaryModel.infoModel.title;
    if(_summaryModel.infoModel.image_list.count == 3){
        _leftImageView.hidden = NO;
        _middleImageView.hidden = NO;
        _rightImageView.hidden = NO;
        
        NSArray *imageArray = self.summaryModel.infoModel.image_list;
        [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            homeNewsImageModel *imageModel = (homeNewsImageModel *)obj;
            UIImageView *imageView = _imageViews[idx];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.url]];
        }];
    }else{
        _leftImageView.hidden = YES;
        _middleImageView.hidden = YES;
        _rightImageView.hidden = YES;
    }
    _infoLabel.text = [NSString stringWithFormat:@"%@   %d阅读了 0 分钟前",_summaryModel.infoModel.media_name,_summaryModel.infoModel.read_count];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    return;
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    return;
}

@end
