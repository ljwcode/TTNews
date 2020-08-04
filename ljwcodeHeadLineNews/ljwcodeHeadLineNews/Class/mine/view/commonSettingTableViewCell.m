//
//  commonSettingTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "commonSettingTableViewCell.h"
#import <Masonry.h>
#import <UIView+Frame.h>

@interface commonSettingTableViewCell()

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,strong)NSArray *infoArray;

@end

static CGFloat Vspace = 30;
static CGFloat Hspace = 30;

static int columns = 4;

@implementation commonSettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(Hspace);
            make.top.mas_equalTo(self.contentView).offset(Vspace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        for(int i = 0;i < self.infoArray.count;i++){
            UIButton *commomButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [commomButton setTitle:self.infoArray[i][@"title"] forState:UIControlStateNormal];
            [commomButton setImage:self.infoArray[i][@"image"] forState:UIControlStateNormal];
            commomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            commomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [self.contentView addSubview:commomButton];
            [commomButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(Hspace+(i%columns)*(Hspace*1.5+((self.contentView.width-(Hspace*5))/4)));
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(Vspace+(i/columns)*(((self.contentView.width-(Hspace*5))/4)+Vspace));
                make.height.mas_equalTo((self.contentView.height - self.titleLabel.height - Vspace * 4) / 2);
                make.width.mas_equalTo((self.contentView.width - Hspace * 5) / 4);
                
            }];
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
                       @{@"title" : @"免流量服务", @"image" : @"profile_system_config"},
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
        label.font = [UIFont systemFontOfSize:18.f];
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
