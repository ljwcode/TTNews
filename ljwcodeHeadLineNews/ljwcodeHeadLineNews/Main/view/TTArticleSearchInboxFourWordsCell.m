//
//  TTArticleSearchInboxFourWordsCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchInboxFourWordsCell.h"

@interface TTArticleSearchInboxFourWordsCell()

@property(nonatomic,strong)UIView *TTArticleSearchTagItemRightView;

@property(nonatomic,strong)UIView *TTArticleSearchTagItemLeftView;

@property(nonatomic,strong)SSThemedView *lineView;

@property(nonatomic,strong)UILabel *leftLabel;

@property(nonatomic,strong)UILabel *rightLabel;

@end

@implementation TTArticleSearchInboxFourWordsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self addSubview:self.TTArticleSearchTagItemLeftView];
        [self.TTArticleSearchTagItemLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth/2);
            make.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.TTArticleSearchTagItemRightView];
        [self.TTArticleSearchTagItemRightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.TTArticleSearchTagItemLeftView.mas_right).offset(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.height.mas_equalTo(self.TTArticleSearchTagItemLeftView);
        }];
        
        
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.TTArticleSearchTagItemLeftView.mas_right).offset(0);
            make.width.mas_equalTo(1);
        }];
        
        [self.TTArticleSearchTagItemLeftView addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth/2 * 0.8);
            make.height.mas_equalTo(44);
        }];
        
        [self.TTArticleSearchTagItemRightView addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(0);
            make.width.height.mas_equalTo(self.leftLabel);
        }];
        
    }
    return self;
}

-(void)setSearchWordsArray:(NSArray *)searchWordsArray{
    self.leftLabel.text = searchWordsArray[0];
    self.rightLabel.text = searchWordsArray[1];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ----- lazy load

-(UIView *)TTArticleSearchTagItemLeftView{
    if(!_TTArticleSearchTagItemLeftView){
        _TTArticleSearchTagItemLeftView = [[UIView alloc]init];
    }
    return _TTArticleSearchTagItemLeftView;
}

-(UIView *)TTArticleSearchTagItemRightView{
    if(!_TTArticleSearchTagItemRightView){
        _TTArticleSearchTagItemRightView = [[UIView alloc]init];
    }
    return  _TTArticleSearchTagItemRightView;
}

-(UILabel *)leftLabel{
    if(!_leftLabel){
        _leftLabel  = [[UILabel alloc]init];
        _leftLabel.text = @"";
        _leftLabel.font = [UIFont systemFontOfSize:15];
        _leftLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _leftLabel.numberOfLines = 1;
        _leftLabel.textColor = [UIColor blackColor];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if(!_rightLabel){
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.text = @"";
        _rightLabel.font = [UIFont systemFontOfSize:15.f];
        _rightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _rightLabel.numberOfLines = 1;
        _rightLabel.textColor = [UIColor blackColor];
    }
    return _rightLabel;
}

-(SSThemedView *)lineView{
    if(!_lineView){
        _lineView = [[SSThemedView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

@end
