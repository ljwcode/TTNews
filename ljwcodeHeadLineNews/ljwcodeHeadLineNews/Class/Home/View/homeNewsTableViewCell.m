//
//  homeNewsTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "TTFeedDislikeView.h"

@interface homeNewsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *NewsTitleLabel;

@property (weak, nonatomic) IBOutlet UIStackView *NewsImgStackView;

@property (weak, nonatomic) IBOutlet UILabel *NewsInfoLabel;

@property (weak, nonatomic) IBOutlet UIButton *NewsDelBtn;

@property (weak, nonatomic) IBOutlet UIImageView *NewsLeftImgView;

@property (weak, nonatomic) IBOutlet UIImageView *NewsMiddleImgView;

@property (weak, nonatomic) IBOutlet UIImageView *NewsRightImgView;

@property(nonatomic,strong)NSArray *imageViews;

@property(nonatomic,strong)TTFeedDislikeView *dislikeView;

@end

@implementation homeNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageViews = @[_NewsLeftImgView,_NewsMiddleImgView,_NewsRightImgView];
    // Initialization code
}

-(void)setSummaryModel:(homeNewsSummaryModel *)summaryModel{
    _summaryModel = summaryModel;
    _NewsTitleLabel.text = _summaryModel.infoModel.title;
    if(_summaryModel.infoModel.image_list.count == 3){
        _NewsLeftImgView.hidden = NO;
        _NewsMiddleImgView.hidden = NO;
        _NewsRightImgView.hidden = NO;
        
        NSArray *imageArray = self.summaryModel.infoModel.image_list;
        [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            homeNewsImageModel *imageModel = (homeNewsImageModel *)obj;
            UIImageView *imageView = _imageViews[idx];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.url]];
        }];
    }else{
        _NewsLeftImgView.hidden = YES;
        _NewsMiddleImgView.hidden = YES;
        _NewsRightImgView.hidden = YES;
    }
    _NewsInfoLabel.text = [NSString stringWithFormat:@"%@   %d阅读了 0 分钟前",_summaryModel.infoModel.media_name,_summaryModel.infoModel.read_count];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    return;
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    return;
}

-(TTFeedDislikeView *)dislikeView{
    if(!_dislikeView){
        _dislikeView = [[TTFeedDislikeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.8, kScreenWidth * 0.8)];
        _dislikeView.center = [self getCurrentWindow].center;
    }
    return _dislikeView;
}

- (IBAction)TT_NewsDelHandle:(id)sender {
    [[self getCurrentWindow] addSubview:self.dislikeView];
//    [self.dislikeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.centerY.mas_equalTo([self getCurrentWindow]);
//        make.width.height.mas_equalTo(kScreenWidth * 0.8);
//    }];
}


@end
