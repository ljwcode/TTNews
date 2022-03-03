//
//  homeNewsMiddleVideoViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsMiddleVideoViewCell.h"
#import "MBProgressHUD+Add.h"

@interface homeNewsMiddleVideoViewCell()

@property(nonatomic,strong)SSThemedLabel *newsTitleLabel;

@property(nonatomic,strong)UIView *newsVideoView;

@property(nonatomic,strong)UIImageView *newsVideoCoverImgView;

@property(nonatomic,strong)UIButton *videoPlayBtn;

@property(nonatomic,strong)SSThemedLabel *videoTimeLabel;

@property(nonatomic,strong)SSThemedLabel *newsInfoLabel;

@property(nonatomic,strong)UIButton *delBtn;

@property(nonatomic,strong)UIView *bottomeLineView;

@end

@implementation homeNewsMiddleVideoViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createUI];
    }
    return self;
}

-(void)createUI{
    [self.contentView addSubview:self.newsTitleLabel];
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    [self.contentView addSubview:self.newsVideoView];
    [self.newsVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.newsTitleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(190);
    }];
    
    [self.newsVideoView addSubview:self.newsVideoCoverImgView];
    [self.newsVideoCoverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.newsVideoView addSubview:self.videoPlayBtn];
    [self.videoPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.newsVideoView);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.newsVideoView addSubview:self.videoTimeLabel];
    [self.videoTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.contentView addSubview:self.newsInfoLabel];
    [self.newsInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.newsVideoView.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth * 0.8);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.contentView addSubview:self.delBtn];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.newsInfoLabel);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.contentView addSubview:self.bottomeLineView];
    [self.bottomeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-2);
        make.top.mas_equalTo(self.newsInfoLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
}

//设置cell数据源
-(void)setSummaryModel:(homeNewsSummaryModel *)summaryModel {
    _summaryModel = summaryModel;
    if([summaryModel.infoModel.label isEqualToString:@"广告"]){
        [self.videoPlayBtn setHidden: YES];
        [self.videoTimeLabel setHidden:YES];
        
        [self.newsTitleLabel setText:summaryModel.infoModel.title];
        [self.newsVideoCoverImgView sd_setImageWithURL:[NSURL URLWithString:summaryModel.infoModel.middle_image.url]];
        NSString *newsPublishTime = [TT_TimeIntervalConverString TT_converTimeIntervalToString:summaryModel.infoModel.publish_time];
        [self.newsInfoLabel setText:[NSString stringWithFormat:@"%@ %@ %@",summaryModel.infoModel.sub_title,summaryModel.infoModel.label,newsPublishTime]];
    }else if(summaryModel.infoModel.has_video){
        [self.videoPlayBtn setHidden: NO];
        [self.videoTimeLabel setHidden:NO];
        
        [self.newsTitleLabel setText:summaryModel.infoModel.title];
        [self.newsVideoCoverImgView sd_setImageWithURL:[NSURL URLWithString:summaryModel.infoModel.middle_image.url]];
    
        NSString *newsPublishTime = [TT_TimeIntervalConverString TT_converTimeIntervalToString:summaryModel.infoModel.publish_time];
        [self.newsInfoLabel setText: [NSString stringWithFormat:@"%@ %@评论 %@",summaryModel.infoModel.media_name,summaryModel.infoModel.comment_count,newsPublishTime]];
        self.videoTimeLabel.text = [NSString stringWithFormat:@"%d : %d",summaryModel.infoModel.video_duration % 60,summaryModel.infoModel.video_duration / 60];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    return;
}

#pragma mark ------ lazy load

-(SSThemedLabel *)newsTitleLabel {
    if(!_newsTitleLabel){
        _newsTitleLabel = [[SSThemedLabel alloc]initWithFrame:CGRectZero fontColor:[UIColor blackColor] fontSize:18 align:NSTextAlignmentLeft];
        [self.newsTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_newsTitleLabel setNumberOfLines: 0];
    }
    return _newsTitleLabel;
}

-(UIView *)newsVideoView {
    if(!_newsVideoView){
        _newsVideoView = [[UIView alloc]init];
    }
    return _newsVideoView;
}

-(UIImageView *)newsVideoCoverImgView {
    if(!_newsVideoCoverImgView){
        _newsVideoCoverImgView = [[UIImageView alloc]init];
    }
    return _newsVideoCoverImgView;
}

-(UIButton *)videoPlayBtn {
    if(!_videoPlayBtn){
        _videoPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoPlayBtn setBackgroundColor:[UIColor clearColor]];
        [_videoPlayBtn setImage:[UIImage imageNamed:@"horizontal_play_icon"] forState:UIControlStateNormal];
        [_videoPlayBtn addTarget:self action:@selector(playVideoHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoPlayBtn;
}

-(SSThemedLabel *)videoTimeLabel {
    if(!_videoTimeLabel){
        _videoTimeLabel = [[SSThemedLabel alloc]initWithFrame:CGRectZero fontColor:[UIColor whiteColor] fontSize:12.f align:NSTextAlignmentRight];
    }
    return _videoTimeLabel;
}

-(SSThemedLabel *)newsInfoLabel {
    if(!_newsInfoLabel){
        _newsInfoLabel = [[SSThemedLabel alloc]initWithFrame:CGRectZero fontColor:[UIColor grayColor] fontSize:12.f align:NSTextAlignmentLeft];
    }
    return _newsInfoLabel;
}

-(UIButton *)delBtn {
    if(!_delBtn){
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delBtn setImage:[UIImage imageNamed:@"close_grade_small"] forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(deleteNewsCellHandle:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _delBtn;
}

-(UIView *)bottomeLineView {
    if(!_bottomeLineView){
        _bottomeLineView = [[UIView alloc]init];
        _bottomeLineView.backgroundColor = [UIColor grayColor];
        _bottomeLineView.alpha = 0.1;
    }
    return _bottomeLineView;
}

#pragma mark ----- 事件响应

-(void)playVideoHandle:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(playVideoHandle)]){
        [self.delegate playVideoHandle];
    }
}

-(void)deleteNewsCellHandle:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(deleteNewsCellHandle)]){
        [self.delegate deleteNewsCellHandle];
    }
}

@end
