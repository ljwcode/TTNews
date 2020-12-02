//
//  TTArticleSearchHeaderCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchHeaderCell.h"

@interface TTArticleSearchHeaderCell()

@end

@implementation TTArticleSearchHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(vSpace);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.actionBtn];
        [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-hSpace);
            make.top.mas_equalTo(vSpace);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.delAllBtn];
        [self.delAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.actionBtn.mas_left).offset(-hSpace);
            make.top.mas_equalTo(self.actionBtn);
            make.width.height.mas_equalTo(self.titleLabel);
        }];
        
    }
    return self;
}

#pragma mark ----- lazy load

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
    }
    return _titleLabel;
}

-(UIButton *)actionBtn{
    if(!_actionBtn){
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _actionBtn;
}

-(UIButton *)delAllBtn{
    if(!_delAllBtn){
        _delAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delAllBtn setTitle:@"全部删除" forState:UIControlStateNormal];
        [_delAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _delAllBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        _delAllBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _delAllBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _delAllBtn;
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
