//
//  TTArticleSearchInboxFourWordsCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchInboxFourWordsCell.h"

@implementation TTArticleSearchInboxFourWordsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        for(int i = 0;i < 2;i++){
            UILabel *TagLabel = [[UILabel alloc]init];
            TagLabel.textColor = [UIColor blackColor];
            TagLabel.textAlignment = NSTextAlignmentCenter;
            TagLabel.font = [UIFont systemFontOfSize:15.f];
            [TagLabel setTag:10030+i];
            [self.contentView addSubview:TagLabel];
            [TagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0+(CGRectGetWidth(self.contentView.frame)/2) * i);
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(CGRectGetWidth(self.contentView.frame)/2);
                if(i == 1){
                    make.right.mas_equalTo(0);
                }
            }];
        }
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(CGRectGetHeight(self.contentView.frame)/2);
        }];
    }
    return self;
}

#pragma mark ----- setter model

-(void)setSearchWordsModel:(TTArticleSearchInboxFourWordsModel *)SearchWordsModel{
    _SearchWordsModel = SearchWordsModel;
    for(int i=0;i<2;i++){
        UILabel *label =(UILabel *)[self viewWithTag:10030 + i];
        label.text = SearchWordsModel.word;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
