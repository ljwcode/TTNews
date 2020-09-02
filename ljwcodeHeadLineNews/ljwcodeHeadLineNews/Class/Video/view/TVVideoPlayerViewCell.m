//
//  TVVideoPlayerViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TVVideoPlayerViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIImage+cropPicture.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@interface TVVideoPlayerViewCell()<UIGestureRecognizerDelegate>

@property (weak, nonatomic)UIImageView *videoBgImgView;

@property (weak, nonatomic)UILabel *videoTitleLabel;

@property (weak, nonatomic)UIButton *videoPlayBtn;

@property (weak, nonatomic)UILabel *videoTimeLabel;

@property (weak, nonatomic)UILabel *videoPlayCountLabel;

@property(nonatomic,weak)UIView *authorBgView;

@property (weak, nonatomic)UIButton *videoAuthHeadBtn;

@property (weak, nonatomic)UIButton *authorFocusBtn;

@property (weak, nonatomic)UIButton *videoCommitRepeatBtn;

@property (weak, nonatomic)UIButton *videoMoreBtn;

@property(nonatomic,strong)NSIndexPath *indexPath;

@end

@implementation TVVideoPlayerViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.videoBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(125);
        }];
        
        [self.videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.centerX.mas_equalTo(self.videoBgImgView);
            make.width.mas_equalTo(self.videoBgImgView.frame.size.width);
            make.height.mas_equalTo(self.videoBgImgView.frame.size.height * 0.5);
        }];
        
        [self.videoPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.videoBgImgView);
            make.width.height.mas_equalTo(60);
        }];
        
        [self.videoPlayCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
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
        
        [self.authorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.videoBgImgView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        
        [self.videoAuthHeadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(2);
            make.bottom.mas_equalTo(2);
            make.height.mas_equalTo(self.authorBgView.height - 4);
        }];
        self.videoAuthHeadBtn.imageView.layer.borderColor = [UIColor redColor].CGColor;
        self.videoAuthHeadBtn.imageView.layer.borderWidth = 2.f;
        
        [self.authorFocusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.videoAuthHeadBtn.mas_right).offset(hSpace);
            make.centerY.mas_equalTo(self.authorBgView);
            make.height.width.mas_equalTo(40);
        }];
        
        [self.videoCommitRepeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_lessThanOrEqualTo(self.authorFocusBtn.mas_right).offset(5 * hSpace);
            make.centerY.mas_equalTo(self.authorFocusBtn);
            make.height.mas_equalTo(self.authorFocusBtn);
            make.width.mas_equalTo(40 * 1.5);
        }];
        
        [self.videoMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-hSpace);
            make.left.mas_equalTo(self.videoCommitRepeatBtn.mas_right).offset(hSpace);
            make.centerY.mas_equalTo(self.authorBgView);
            make.height.width.mas_equalTo(self.authorFocusBtn);
        }];
        
    }
    return self;
}

#pragma mark -- set model
-(void)setContentModel:(videoContentModel *)contentModel{
    _contentModel = contentModel;
    [self.videoBgImgView sd_setImageWithURL:[NSURL URLWithString:[contentModel.detailModel.video_detail_info.detail_video_large_image objectForKey:@"url"]]];
    [self.videoAuthHeadBtn setTitle:contentModel.detailModel.media_name forState:UIControlStateNormal];
    self.videoTitleLabel.text = contentModel.detailModel.title;
//    [self.videoAuthHeadBtn.imageView sd_setImageWithURL:[NSURL URLWithString: contentModel.detailModel.media_info.avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if(image){
//            self.videoAuthHeadBtn.imageView.image = [image cropPictureWithRoundedCorner:self.videoAuthHeadBtn.imageView.image.size.width size:self.videoAuthHeadBtn.frame.size];
//        }
//    }];
    [self.videoAuthHeadBtn.imageView sd_setImageWithURL:[NSURL URLWithString:contentModel.detailModel.media_info.avatar_url]];
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
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17.f];
        label.numberOfLines = 2;

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

-(UIView *)authorBgView{
    if(!_authorBgView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor grayColor];
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
        [btn.titleLabel sizeToFit];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
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
        [btn addTarget:self action:@selector(focusHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.authorBgView addSubview:btn];
        _authorFocusBtn = btn;
    }
    return _authorFocusBtn;
}

-(UIButton *)videoCommitRepeatBtn{
    if(!_videoCommitRepeatBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"评论" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"comment_24x24_"] forState:UIControlStateNormal];
        [btn.titleLabel sizeToFit];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [btn addTarget:self action:@selector(commitRepesatHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.authorBgView addSubview:btn];
        _videoCommitRepeatBtn = btn;
    }
    return _videoCommitRepeatBtn;
}

-(UIButton *)videoMoreBtn{
    if(!_videoMoreBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"More_24x24_"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.authorBgView addSubview:btn];
        _videoMoreBtn = btn;
    }
    return _videoMoreBtn;
}

-(void)setDelegate:(id<TVVideoPlayerCellDelegate,NSObject>)delegate withIndexPath:(NSIndexPath *)indexPath{
    self.delegate = delegate;
    self.indexPath = indexPath;
}

#pragma mark -- 点击事件响应
-(void)clickPlayHandle:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(VideoPlayerAtIndexPath:)]){
        [self.delegate VideoPlayerAtIndexPath:self.indexPath];
    }
}

-(void)videoDetailHandle:(UIGestureRecognizer *)ges{
    
}

-(void)focusHandle:(UIButton *)sender{
    
}

-(void)commitRepesatHandle:(UIButton *)sender{
    
}

-(void)moreHandle:(UIButton *)sender{
    
}

-(void)setNormalModel{
    self.videoBgImgView.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
