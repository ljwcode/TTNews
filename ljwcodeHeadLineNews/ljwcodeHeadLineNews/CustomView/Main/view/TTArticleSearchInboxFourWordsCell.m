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
            TagLabel.textAlignment = NSTextAlignmentLeft;
            TagLabel.font = [UIFont systemFontOfSize:17.f];
            [TagLabel setTag:1+i];
            [self.contentView addSubview:TagLabel];

            [TagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace+(kScreenWidth/2) * i);
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(kScreenWidth/2 - hSpace * 2);
                
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
        
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-hSpace);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(kScreenWidth - 2 * hSpace);
        }];
    }
    return self;
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
