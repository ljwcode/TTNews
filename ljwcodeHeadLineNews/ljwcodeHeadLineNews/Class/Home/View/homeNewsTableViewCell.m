//
//  homeNewsTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "TTFeedDislikeView.h"
#import "TT_TimeIntervalConverString.h"

/*
 无需展示图片
 */
@interface homeNewsTableViewCell()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)SSThemedLabel *newsTitleLabel;

@property(nonatomic,strong)SSThemedLabel *onTopLabel;

@property(nonatomic,strong)SSThemedLabel *newsInfoLablel;

@property(nonatomic,strong)NSArray *imageViews;

@property(nonatomic,strong)TTFeedDislikeView *dislikeView;

@property(nonatomic,strong)UITapGestureRecognizer *tapGes;

@end

@implementation homeNewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createUI];
    }
    return self;
}

-(void)createUI {
        [self.contentView addSubview:self.onTopLabel];
        [self.onTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(10);
        }];
        
        [self.contentView addSubview:self.newsInfoLablel];
        [self.newsInfoLablel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.onTopLabel.mas_right).offset(5);
            make.bottom.mas_equalTo(self.onTopLabel);
            make.height.mas_equalTo(self.onTopLabel);
            make.width.mas_greaterThanOrEqualTo(100);
            make.right.mas_lessThanOrEqualTo(kScreenWidth - 10 - 100 - 20 - 10);
        }];
    
    
    [self.contentView addSubview:self.newsTitleLabel];
    
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.newsInfoLablel.mas_top).offset(-10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
    }];
}

-(void)setSummaryModel:(homeNewsSummaryModel *)summaryModel{
    _summaryModel = summaryModel;
    [self.onTopLabel setHidden:NO];
    _newsTitleLabel.text = _summaryModel.infoModel.title;
    NSString *publish_time = [NSString stringWithFormat:@"%@",[TT_TimeIntervalConverString TT_converTimeIntervalToString:_summaryModel.infoModel.publish_time]];
    _newsInfoLablel.text = [NSString stringWithFormat:@"%@   %@评论 %@",_summaryModel.infoModel.media_name,_summaryModel.infoModel.comment_count,publish_time];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    return;
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    return;
}

-(TTFeedDislikeView *)dislikeView{
    if(!_dislikeView){
        _dislikeView = [[TTFeedDislikeView alloc]init];
    }
    return _dislikeView;
}

#pragma mark ------ UIGestureRecognizerDelegate

-(void)TT_tapOtherLocationHandle:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded){
        CGPoint tapPoint = [tap locationInView:[self getCurrentWindow].rootViewController.view];
        CGRect dislikeViewRect = self.dislikeView.bounds;
        if (self.dislikeView && !CGRectContainsPoint(dislikeViewRect, tapPoint)){
            [self TT_disMissView];
        }
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)TT_disMissView{
    [self.dislikeView removeFromSuperview];
    self.dislikeView = NULL;
}

#pragma mark ------- lazy load

-(SSThemedLabel *)newsTitleLabel {
    if(!_newsTitleLabel){
        _newsTitleLabel = [[SSThemedLabel alloc]initWithFrame:CGRectZero fontColor:[UIColor blackColor] fontSize:18 align:NSTextAlignmentLeft];
        _newsTitleLabel.numberOfLines = 0;
        _newsTitleLabel.preferredMaxLayoutWidth = kScreenWidth - 20;
        [self.newsTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _newsTitleLabel;
}

-(SSThemedLabel *)onTopLabel {
    if(!_onTopLabel){
        _onTopLabel = [[SSThemedLabel alloc]initWithFrame:CGRectZero fontColor:[UIColor redColor] fontSize:8 align:NSTextAlignmentCenter];
        _onTopLabel.text = @"置顶";
    }
    return _onTopLabel;
}

-(SSThemedLabel *)newsInfoLablel {
    if(!_newsInfoLablel){
        _newsInfoLablel = [[SSThemedLabel alloc]initWithFrame:CGRectZero fontColor:[UIColor grayColor] fontSize:10 align:NSTextAlignmentLeft];
    }
    return _newsInfoLablel;
}

@end
