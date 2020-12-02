//
//  TTArticleSearchInboxFourWordsCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchInboxFourWordsCell.h"

@interface TTArticleSearchInboxFourWordsCell()

@property(nonatomic,strong)UIView *leftSearchHistoryTagView;

@property(nonatomic,strong)UILabel *leftTagLabel;

@property(nonatomic,strong)UIView *rightSearchHistoryTagView;

@property(nonatomic,strong)UILabel *rightTagLabel;

@end

@implementation TTArticleSearchInboxFourWordsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.leftSearchHistoryTagView];
        [self.leftSearchHistoryTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self.width/2 - hSpace);
        }];
        
        [self.leftSearchHistoryTagView addSubview:self.leftTagLabel];
        [self.leftTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self.leftSearchHistoryTagView.width * 0.8);
        }];
        
        [self.contentView addSubview:self.rightSearchHistoryTagView];
        [self.rightSearchHistoryTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self.width/2 - hSpace);
        }];
        
        [self.rightSearchHistoryTagView addSubview:self.rightTagLabel];
        [self.rightTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self.leftTagLabel);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(1);
        }];
    }
    return self;
}

#pragma mark ------ lazy load

-(UIView *)leftSearchHistoryTagView{
    if(!_leftSearchHistoryTagView){
        _leftSearchHistoryTagView = [[UIView alloc]init];
    }
    return _leftSearchHistoryTagView;
}

-(UILabel *)leftTagLabel{
    if(!_leftTagLabel){
        _leftTagLabel = [[UILabel alloc]init];
        _leftTagLabel.textColor = [UIColor blackColor];
        _leftTagLabel.font = [UIFont systemFontOfSize:13.f];
        _leftTagLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _leftTagLabel;
}

-(UIView *)rightSearchHistoryTagView{
    if(!_rightSearchHistoryTagView){
        _rightSearchHistoryTagView = [[UIView alloc]init];
    }
    return _rightSearchHistoryTagView;
}

-(UILabel *)rightTagLabel{
    if(!_rightTagLabel){
        _rightTagLabel = [[UILabel alloc]init];
        _rightTagLabel.textColor = [UIColor blackColor];
        _rightTagLabel.font = [UIFont systemFontOfSize:13.f];
        _rightTagLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightTagLabel;
}

#pragma mark ----- setter model

-(void)setSearchWordsModel:(TTArticleSearchInboxFourWordsModel *)SearchWordsModel{
    _SearchWordsModel = SearchWordsModel;
    self.leftTagLabel.text = SearchWordsModel.word;
    self.rightTagLabel.text = SearchWordsModel.word;
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
