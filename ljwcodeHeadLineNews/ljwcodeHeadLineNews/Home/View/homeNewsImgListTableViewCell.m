//
//  homeNewsImgListTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsImgListTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "TT_TimeIntervalConverString.h"

@interface homeNewsImgListTableViewCell()

@property(nonatomic,strong)SSThemedLabel *newsTitleLabel;

@property(nonatomic,strong)UIImageView *leftImgView;

@property(nonatomic,strong)UIImageView *middleImgView;

@property(nonatomic,strong)UIImageView *rightImgView;

@property(nonatomic,strong)SSThemedLabel *newsInfoLabel;

@property(nonatomic,strong)UIButton *delBtn;

@property(nonatomic,strong)NSArray *imgViewsArray;

@property(nonatomic,strong)UIView *bottomLineView;

@end

@implementation homeNewsImgListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.imgViewsArray = @[self.leftImgView,self.middleImgView,self.rightImgView];
        [self createUI];
    }
    return self;
}

-(void)createUI {
    [self.contentView addSubview:self.newsTitleLabel];
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(50);
    }];
    
    [self.contentView addSubview:self.leftImgView];
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.newsTitleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo((kScreenWidth - 20 - 10)/3);
    }];
    
    [self.contentView addSubview:self.middleImgView];
    [self.middleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImgView.mas_right).offset(5);
        make.width.height.mas_equalTo(self.leftImgView);
        make.top.mas_equalTo(self.leftImgView);
    }];
    
    [self.contentView addSubview:self.rightImgView];
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.middleImgView.mas_right).offset(5);
        make.top.mas_equalTo(self.leftImgView);
        make.width.height.mas_equalTo(self.leftImgView);
    }];
    
    [self.contentView addSubview:self.newsInfoLabel];
    [self.newsInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.leftImgView.mas_bottom).offset(5);
        make.width.mas_greaterThanOrEqualTo(kScreenWidth / 3);
        make.right.mas_lessThanOrEqualTo(kScreenWidth - (kScreenWidth / 3) - 20 - 20 - 10);
    }];
    
    [self.contentView addSubview:self.delBtn];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.newsInfoLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-2);
        make.height.mas_equalTo(1);
    }];
    
}

-(void)setNewsSummaryModel:(homeNewsSummaryModel *)newsSummaryModel{
    _newsSummaryModel = newsSummaryModel;
    [self.newsTitleLabel setText:newsSummaryModel.infoModel.title];
    NSString *newsPublishTime = [NSString stringWithFormat:@"%@",[TT_TimeIntervalConverString TT_converTimeIntervalToString:newsSummaryModel.infoModel.publish_time]];
    [self.newsInfoLabel setText:[NSString stringWithFormat:@"%@ %@评论 %@",newsSummaryModel.infoModel.media_name,newsSummaryModel.infoModel.comment_count,newsPublishTime]];
    NSArray *imageArray = newsSummaryModel.infoModel.image_list;
    [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        homeNewsImageModel *imageModel = (homeNewsImageModel *)obj;
        UIImageView *imageView = self.imgViewsArray[idx];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.url]];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ------- lazy load

-(SSThemedLabel *)newsTitleLabel {
    if(!_newsTitleLabel){
        _newsTitleLabel = [[SSThemedLabel alloc]initWithFrame:CGRectZero fontColor:[UIColor blackColor] fontSize:18.f align:NSTextAlignmentLeft];
        [_newsTitleLabel setNumberOfLines:0];
        [_newsTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _newsTitleLabel;
}

-(UIImageView *)leftImgView {
    if(!_leftImgView){
        _leftImgView = [[UIImageView alloc]init];
    }
    return _leftImgView;
}

-(UIImageView *)middleImgView {
    if(!_middleImgView){
        _middleImgView = [[UIImageView alloc]init];
    }
    return _middleImgView;
}

-(UIImageView *)rightImgView {
    if(!_rightImgView){
        _rightImgView = [[UIImageView alloc]init];
    }
    return _rightImgView;
}

-(SSThemedLabel *)newsInfoLabel {
    if(!_newsInfoLabel){
        _newsInfoLabel = [[SSThemedLabel alloc]initWithFrame:CGRectZero fontColor:[UIColor grayColor] fontSize:12.f align:NSTextAlignmentLeft];
        [_newsInfoLabel setNumberOfLines:1];
    }
    return _newsInfoLabel;
}

-(UIButton *)delBtn {
    if(!_delBtn){
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delBtn setImage:[UIImage imageNamed:@"close_grade_small"] forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(deleteCellHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

-(NSArray *)imgViewsArray {
    if(!_imgViewsArray){
        _imgViewsArray = [[NSArray alloc]init];
    }
    return _imgViewsArray;
}

-(UIView *)bottomLineView {
    if(!_bottomLineView){
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [UIColor grayColor];
        _bottomLineView.alpha = 0.1;
    }
    return _bottomLineView;
}


#pragma mark -------- 事件响应

-(void)deleteCellHandle:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(TTDeleteNewsCellHandle)]){
        [self.delegate TTDeleteNewsCellHandle];
    }
}


@end
