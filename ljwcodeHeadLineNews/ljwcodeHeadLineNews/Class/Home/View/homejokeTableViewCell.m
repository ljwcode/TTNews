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

@property (weak, nonatomic) IBOutlet UIButton *NewsHeadImgBtn;

@property (weak, nonatomic) IBOutlet UILabel *NewsAuthNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *NewsAuthInfoLabel;

@property (weak, nonatomic) IBOutlet UIButton *NewsFocusBtn;

@property (weak, nonatomic) IBOutlet UILabel *NewsInfoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *NewsInfoImgView;

@property (weak, nonatomic) IBOutlet UIButton *NewsShareBtn;

@property (weak, nonatomic) IBOutlet UILabel *NewsLocalInfoLabel;

@property (weak, nonatomic) IBOutlet UIButton *NewsCommentBtn;

@property (weak, nonatomic) IBOutlet UIButton *NewsRepeatBtn;

@property (weak, nonatomic) IBOutlet UIButton *NewsDelBtn;


@end

@implementation homejokeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1.f;
    // Initialization code
}

//设置cell数据源
-(void)setJokeSummaryModel:(homeJokeSummarymodel *)jokeSummaryModel{
    _jokeSummaryModel = jokeSummaryModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    return;
}

@end
