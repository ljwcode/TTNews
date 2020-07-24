//
//  commonSettingTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "commonSettingTableViewCell.h"
#import "buttonStyleTwo.h"
#import <Masonry.h>

@interface commonSettingTableViewCell()

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,weak)buttonStyleTwo *commomButton;

@property(nonatomic,strong)NSArray *infoArray;

@end

static CGFloat Vspace = 10;
static CGFloat Hspace = 10;
static CGFloat buttonWidth = 30;
static CGFloat buttonHeight = 30;
static int columns = 4;

#define isCommonSettingFrame(i) CGRectMake(Hspace*3+(i%columns)*(Hspace+buttonWidth), CGRectGetMaxY(self.titleLabel.frame)+Vspace+(i/columns)*(Vspace+buttonHeight), buttonWidth, buttonHeight)

@implementation commonSettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(Hspace);
            make.top.mas_equalTo(self.contentView).offset(Vspace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        for(int i = 0;i < _infoArray.count;i++){
            buttonStyleTwo *commomButton = [[buttonStyleTwo alloc]init];
            commomButton.frame = isCommonSettingFrame(i);
            [commomButton configrueTitle:_infoArray[i][@"title"] img:_infoArray[i][@"image"]];
            [self.contentView addSubview:commomButton];
        }
    }
    return self;
}

-(NSArray *)infoArray{
    if(!_infoArray){
        _infoArray = [[NSArray alloc]init];
        _infoArray = @[@{@"title" : @"关注", @"image" : @"profile_my_follow"},
                       @{@"title" : @"消息通知", @"image" : @"profile_msg_notification"},
                       @{@"title" : @"收藏", @"image" : @"profile_v2_my_favorite"},
                       @{@"title" : @"浏览历史", @"image" : @"profile_v2_my_history"},
                       @{@"title" : @"钱包", @"image" : @"profile_v2_my_wallet"},
                       @{@"title" : @"用户反馈", @"image" : @"profile_user_feedback"},
                       @{@"title" : @"免流量服务", @"image" : @""},
                       @{@"title" : @"系统设置", @"image" : @"profile_system_config"}
        ];
    }
    return _infoArray;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"常用功能";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13.f];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
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
