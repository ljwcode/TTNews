//
//  TTArticleSearchCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchCell.h"

@interface TTArticleSearchCell()

@property(nonatomic,strong)UIView *leftSearchHistoryTagView;

@property(nonatomic,strong)UILabel *leftTagLabel;

@property(nonatomic,strong)UIButton *leftDelTagBtn;

@property(nonatomic,strong)UIView *rightSearchHistoryTagView;

@property(nonatomic,strong)UILabel *rightTagLabel;

@property(nonatomic,strong)UIButton *rightDelTagBtn;

@end

@implementation TTArticleSearchCell

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
        
        [self.leftSearchHistoryTagView addSubview:self.leftDelTagBtn];
        [self.leftDelTagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.leftTagLabel.mas_right).offset(2);
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
        
        [self.rightSearchHistoryTagView addSubview:self.rightDelTagBtn];
        [self.rightDelTagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.rightTagLabel.mas_right).offset(2);
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

-(UIButton *)leftDelTagBtn{
    if(!_leftDelTagBtn){
        _leftDelTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftDelTagBtn setImage:[UIImage imageNamed:@"ad_form_close"] forState:UIControlStateNormal];
    }
    return _leftDelTagBtn;
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

-(UIButton *)rightDelTagBtn{
    if(!_rightDelTagBtn){
        _rightDelTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightDelTagBtn setImage:[UIImage imageNamed:@"ad_form_close"] forState:UIControlStateNormal];
    }
    return _rightDelTagBtn;
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