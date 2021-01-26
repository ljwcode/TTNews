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
