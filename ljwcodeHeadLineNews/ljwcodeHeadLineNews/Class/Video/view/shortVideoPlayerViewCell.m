//
//  shortVideoPlayerViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/10.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "shortVideoPlayerViewCell.h"
#import "videoPlayerToolView.h"

@interface shortVideoPlayerViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *shortVideoBgImgView;

@property (weak, nonatomic) IBOutlet UILabel *shortVideoTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *shortVideoPlayBtn;

@property (weak, nonatomic) IBOutlet UILabel *shortVideoTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortVideoPlayCount;


@property (weak, nonatomic) IBOutlet UIButton *shortVideoMoreBtn;

@property (weak, nonatomic) IBOutlet UIButton *shortVideoFocusBtn;

@property (weak, nonatomic) IBOutlet UIButton *shortVideoCommitRepeatBtn;

@property (weak, nonatomic) IBOutlet UILabel *shortVideoInfoLabel;


@property (weak, nonatomic) IBOutlet UIButton *shortVideoAuthorHeadImgBtn;


@end

@implementation shortVideoPlayerViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end