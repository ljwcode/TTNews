//
//  TT_ClickHightLightTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/7.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_ClickHightLightTableViewCell.h"

@implementation TT_ClickHightLightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selected = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.contentView.backgroundColor = [UIColor lightGrayColor];
        } completion:^(BOOL finished) {
            if(finished){
                self.contentView.backgroundColor = [UIColor whiteColor];
            }
        }];
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
