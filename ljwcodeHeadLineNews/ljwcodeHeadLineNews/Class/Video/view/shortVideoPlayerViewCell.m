//
//  shortVideoPlayerViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/10.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "shortVideoPlayerViewCell.h"
#import "videoPlayerToolView.h"
#import <UIImageView+WebCache.h>
#import "UIImage+cropPicture.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@interface shortVideoPlayerViewCell()

@property (weak, nonatomic)UIImageView *videoBgImgView;

@property (weak, nonatomic)UILabel *videoTitleLabel;

@property (weak, nonatomic)UIButton *videoPlayBtn;

@property (weak, nonatomic)UILabel *videoTimeLabel;

@property (weak, nonatomic)UILabel *videoPlayCountLabel;

@property(nonatomic,weak)UIView *videoDetailBgView;

@property (weak, nonatomic)UIButton *videoDetailImgBtn;

@property(nonatomic,weak)UILabel *videoNameLabel;

@property(nonatomic,weak)UILabel *watchVideoLabel;

@property(nonatomic,weak)UILabel *videoDetailLabel;


@property(nonatomic,weak)UIView *authorBgView;

@property (weak, nonatomic)UIButton *videoAuthHeadBtn;

@property (weak, nonatomic)UIButton *authorFocusBtn;

@property (weak, nonatomic)UIButton *videoCommitRepeatBtn;

@property (weak, nonatomic)UIButton *videoMoreBtn;


@end

@implementation shortVideoPlayerViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.videoBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(self.contentView.height * 0.6);
        }];
        
        [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(2 * hSpace);
            make.top.mas_equalTo(vSpace);
            make.right.mas_equalTo(2 * hSpace);
            make.height.mas_equalTo(self.videoBgImgView.height * 0.2);
        }];
        
        [self.videoPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.videoBgImgView);
            make.width.height.mas_equalTo(60);
        }];
        
        [self.videoPlayCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(2 * hSpace);
            make.bottom.mas_equalTo(2 * vSpace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        [self.videoTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(hSpace);
            make.bottom.mas_equalTo(2 * vSpace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        [self.videoDetailBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.videoBgImgView);
            make.height.mas_equalTo(self.contentView.height * 0.2);
        }];
        
        [self.videoDetailImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(2 * hSpace);
            make.top.mas_equalTo(vSpace);
            make.bottom.mas_equalTo(vSpace);
        }];
        
        [self.videoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.videoDetailImgBtn.mas_right).offset(2 * hSpace);
            make.top.mas_equalTo(self.videoDetailImgBtn);
            make.height.mas_equalTo(self.videoDetailImgBtn.height / 2);
        }];
        
        [self.watchVideoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.videoNameLabel.mas_right).offset(2 * hSpace);
            make.top.mas_equalTo(self.videoNameLabel);
            make.height.mas_equalTo(self.videoNameLabel);
        }];
        
        [self.videoDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.videoNameLabel);
            make.top.mas_equalTo(self.videoNameLabel.mas_bottom).offset(vSpace);
            make.bottom.mas_equalTo(-2 * vSpace);
        }];
        
        [self.authorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.videoDetailBgView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(self.contentView.height * 0.2);
        }];
        
        [self.videoAuthHeadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(2 * hSpace);
            make.centerY.mas_equalTo(self.authorBgView);
            make.height.mas_equalTo(self.authorBgView.height - 4 * vSpace);
        }];
        
        [self.authorFocusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.videoAuthHeadBtn.mas_right).offset(2 * hSpace);
            make.centerY.mas_equalTo(self.videoAuthHeadBtn);
            make.height.width.mas_equalTo(self.videoAuthHeadBtn.height / 3);
        }];
        
        [self.videoCommitRepeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.authorFocusBtn.mas_right).offset(self.authorBgView.width/3);
            make.centerY.mas_equalTo(self.authorFocusBtn);
            make.width.height.mas_equalTo(self.authorFocusBtn);
        }];
        
        [self.videoMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(2 * hSpace);
            make.left.mas_equalTo(self.videoCommitRepeatBtn.mas_right).offset(3 * hSpace);
            make.centerY.mas_equalTo(self.authorBgView);
            make.height.width.mas_equalTo(self.authorFocusBtn);
        }];
        
    }
    return self;
}

-(void)setContentModel:(videoContentModel *)contentModel{
    _contentModel = contentModel;
    [self.videoBgImgView sd_setImageWithURL:[NSURL URLWithString:contentModel.detailModel.playInfoModel.poster_url]];
    [self.videoAuthHeadBtn setTitle:contentModel.detailModel.media_name forState:UIControlStateNormal];
    self.videoTitleLabel.text = contentModel.detailModel.title;
    [self.videoAuthHeadBtn.imageView sd_setImageWithURL:[NSURL URLWithString: contentModel.detailModel.userInfoModel.avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            self.videoAuthHeadBtn.imageView.image = [image cropPictureWithRoundedCorner:self.videoAuthHeadBtn.imageView.image.size.width/2 size:self.videoAuthHeadBtn.frame.size];
        }
    }];
    self.videoPlayCountLabel.text = @"20W";
    self.videoTimeLabel.text = @"20:20";
}


#pragma mark -- lzay load

-(UIImageView *)videoBgImgView{
    if(!_videoBgImgView){
        UIImageView *imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:imgView];
        _videoBgImgView = imgView;
    }
    return _videoBgImgView;
}

-(UILabel *)videoTitleLabel{
    if(!_videoTitleLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17.f];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        [self.videoBgImgView addSubview:label];
        _videoTitleLabel = label;
    }
    return _videoTitleLabel;
}

-(UIButton *)videoPlayBtn{
    if(!_videoPlayBtn){
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"toutiaovideo"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickPlayHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.videoBgImgView addSubview:btn];
        _videoPlayBtn = btn;
    }
    return _videoPlayBtn;
}

-(UILabel *)videoPlayCountLabel{
    if(!_videoPlayCountLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10.f];
        [self.videoBgImgView addSubview:label];
        _videoPlayCountLabel = label;
    }
    return _videoPlayCountLabel;
}

-(UILabel *)videoTimeLabel{
    if(!_videoTimeLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10.f];
        label.backgroundColor = [UIColor blackColor];
        label.alpha = 0.4;
        label.layer.cornerRadius = 10.f;
        [self.videoBgImgView addSubview:label];
        _videoTimeLabel = label;
    }
    return _videoTimeLabel;
}

-(UIView *)videoDetailBgView{
    if(!_videoDetailBgView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor grayColor];
        UIGestureRecognizer *gesRec = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(videoDetailHandle:)];
        gesRec.delegate = self;
        [view addGestureRecognizer:gesRec];
        [self.contentView addSubview:view];
        _videoDetailBgView = view;
    }
    return _videoDetailBgView;
}

-(UIButton *)videoDetailImgBtn{
    if(!_videoDetailImgBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.videoBgImgView addSubview:btn];
        _videoDetailImgBtn = btn;
    }
    return _videoDetailImgBtn;
}

-(UILabel *)videoNameLabel{
    if(!_videoNameLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13.f];
        label.textAlignment = NSTextAlignmentCenter;
        [self.videoDetailBgView addSubview:label];
        _videoNameLabel = label;
    }
    return _videoNameLabel;
}

-(UILabel *)watchVideoLabel{
    if(!_watchVideoLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13.f];
        label.text = @"看完整版>";
        [self.videoDetailBgView addSubview:label];
        _watchVideoLabel = label;
    }
    return _watchVideoLabel;
}

-(UILabel *)videoDetailLabel{
    if(!_videoDetailLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10.f];
        [self.videoDetailBgView addSubview:label];
        _videoDetailLabel = label;
    }
    return _videoDetailLabel;
}

-(UIView *)authorBgView{
    if(_authorBgView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _authorBgView = view;
    }
    return _authorBgView;
}

-(UIButton *)videoAuthHeadBtn{
    if(!_videoAuthHeadBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [self.authorBgView addSubview:btn];
        
        _videoAuthHeadBtn = btn;
    }
    return _videoAuthHeadBtn;
}

-(UIButton *)authorFocusBtn{
    if(!_authorFocusBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"关注" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [self.authorBgView addSubview:btn];
        _authorFocusBtn = btn;
    }
    return _authorFocusBtn;
}

-(UIButton *)videoCommitRepeatBtn{
    if(!_videoCommitRepeatBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"comment_24x24_"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [self.authorBgView addSubview:btn];
        _videoCommitRepeatBtn = btn;
    }
    return _videoCommitRepeatBtn;
}

-(UIButton *)videoMoreBtn{
    if(!_videoMoreBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"More_24x24_"] forState:UIControlStateNormal];
        [self.authorBgView addSubview:btn];
        _videoMoreBtn = btn;
    }
    return _videoMoreBtn;
}

#pragma mark -- 点击事件响应
-(void)clickPlayHandle:(UIButton *)sender{
    
}

-(void)videoDetailHandle:(UIGestureRecognizer *)ges{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
