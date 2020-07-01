//
//  homejokeTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homejokeTableViewCell.h"
#import "MBProgressHUD+Add.h"

@interface homejokeTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@property (weak, nonatomic) IBOutlet UIButton *disLikeBtn;

@property (weak, nonatomic) IBOutlet UIButton *repeatBtn;

@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property(nonatomic,weak)UILabel *plusLabel;


@end

@implementation homejokeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"+1";
    label.font = [UIFont systemFontOfSize:18];
    label.frame = CGRectMake(0, 0, 20, 20);
    label.textColor = [UIColor colorWithRed:0.97 green:0.35 blue:0.35 alpha:1.0];
    label.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    label.hidden = YES;
    _plusLabel = label;
    label.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self.contentView addSubview:label];
    // Initialization code
}

//设置cell数据源
-(void)setJokeSummaryModel:(homeJokeSummarymodel *)jokeSummaryModel{
    _jokeSummaryModel = jokeSummaryModel;
    _contentLabel.text = _jokeSummaryModel.infoModel.content;
    _likeBtn.selected = _jokeSummaryModel.starBtnSelected;
    _disLikeBtn.selected = _jokeSummaryModel.hateBtnSelected;
    _collectionBtn.selected = _jokeSummaryModel.collectionSelected;
    
    [_likeBtn setTitle:[NSString stringWithFormat:@"%d",_jokeSummaryModel.infoModel.star_count] forState:UIControlStateNormal];
    [_disLikeBtn setTitle:[NSString stringWithFormat:@"%d",_jokeSummaryModel.infoModel.hate_count] forState:UIControlStateNormal];
    [_repeatBtn setTitle:[NSString stringWithFormat:@"%d",_jokeSummaryModel.infoModel.comment_count] forState:UIControlStateNormal];
    
}

- (IBAction)likeBtnHandle:(UIButton *)sender {
    if([self showLog]){
        return;
    }
    sender.selected = !sender.selected;
    _jokeSummaryModel.starBtnSelected = sender.selected;
    _jokeSummaryModel.infoModel.star_count += 1;
}

- (IBAction)disLikeBtnHandle:(UIButton *)sender {
    if([self showLog]){
        return;
    }
    sender.selected = !sender.selected;
    _jokeSummaryModel.hateBtnSelected = sender.selected;
    _jokeSummaryModel.infoModel.hate_count += 1;
}

- (IBAction)collectionBtnHandle:(UIButton *)sender {
    sender.selected = !sender.selected;
    _jokeSummaryModel.collectionSelected = sender.selected;
}

-(BOOL)showLog{
    if(_likeBtn.selected){
        [MBProgressHUD showSuccess:@"您已经赞过了" toView:nil];
        return YES;
    }
    if(_disLikeBtn.selected){
        [MBProgressHUD showError:@"您已经踩过了" toView:nil];
        return YES;
    }
    return NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
