//
//  TTArticleSearchTagCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchTagCell.h"

@interface TTArticleSearchTagCell()

@property (weak, nonatomic) IBOutlet UIView *leftSearchTagItemView;
@property (weak, nonatomic) IBOutlet UILabel *leftSearchTagItemLabel;

@property (weak, nonatomic) IBOutlet UIView *rightSearchTagItemView;
@property (weak, nonatomic) IBOutlet UILabel *rightSearchTagItemLabel;


@end

@implementation TTArticleSearchTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
