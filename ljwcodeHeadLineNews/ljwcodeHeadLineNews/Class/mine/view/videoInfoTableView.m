//
//  videoInfoTableView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoInfoTableView.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@interface videoInfoTableView()

@property(nonatomic,weak)UIImageView *videoCoverImgView;

@property(nonatomic,weak)UILabel *tipLabel;

@property(nonatomic,weak)UILabel *detailLabel;

@property(nonatomic,assign)CGFloat playPercent;

@property(nonatomic,copy)NSString *detailText;


@end

@implementation videoInfoTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self.videoCoverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.height.mas_equalTo(self.height * 0.8);
            make.width.mas_equalTo(self.width);
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.videoCoverImgView.mas_left).offset(5);
            make.bottom.mas_equalTo(self.videoCoverImgView.mas_bottom).offset(2);
            make.width.mas_equalTo(self.videoCoverImgView.width/4);
            make.height.mas_equalTo(10);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self.videoCoverImgView.mas_bottom).offset(2);
            make.width.mas_equalTo(self.width);
            make.height.mas_equalTo(self.height * 0.2);
        }];
    }
    return self;
}

-(UIImageView *)videoCoverImgView{
    if(!_videoCoverImgView){
        UIImageView *imgView = [[UIImageView alloc]init];
        [self addSubview:imgView];
        _videoCoverImgView = imgView;
    }
    return _videoCoverImgView;
}

-(UILabel *)tipLabel{
    if(!_tipLabel){
        UILabel *tipLabel = [[UILabel alloc]init];
        tipLabel.text = [NSString stringWithFormat:@"已看%f",_playPercent];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.font = [UIFont systemFontOfSize:10.f];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.videoCoverImgView addSubview:tipLabel];
        _tipLabel = tipLabel;
    }
    return _tipLabel;
}

-(UILabel *)detailLabel{
    if(!_detailLabel){
        UILabel *detailLabel = [[UILabel alloc]init];
        detailLabel.text = _detailText;
        detailLabel.font = [UIFont systemFontOfSize:12.f];
        detailLabel.textColor = [UIColor blackColor];
        [self addSubview:detailLabel];
        _detailLabel = detailLabel;
    }
    return _detailLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
