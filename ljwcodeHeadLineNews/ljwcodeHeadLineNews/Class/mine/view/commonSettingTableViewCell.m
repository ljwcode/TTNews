//
//  commonSettingTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "commonSettingTableViewCell.h"
#import "focusViewController.h"
#import "MessageViewController.h"

@interface commonSettingTableViewCell()

@property(nonatomic,strong)focusViewController *focusVC;

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,strong)NSArray *infoArray;

@end

static int columns = 4;

@implementation commonSettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(hSpace * 3);
            make.top.mas_equalTo(self.contentView).offset(vSpace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
       
        for(int i = 0;i < self.infoArray.count;i++){
            UIButton *commomButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [commomButton setTitle:self.infoArray[i][@"title"] forState:UIControlStateNormal];
            [commomButton setImage:[UIImage imageNamed:self.infoArray[i][@"image"]] forState:UIControlStateNormal];
            [commomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            commomButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
            [self.contentView addSubview:commomButton];
            [commomButton.titleLabel sizeToFit];
            
            commomButton.imageEdgeInsets = UIEdgeInsetsMake(-commomButton.titleLabel.intrinsicContentSize.height, 0, 0, -commomButton.titleLabel.intrinsicContentSize.width);
            
            commomButton.titleEdgeInsets = UIEdgeInsetsMake(commomButton.imageView.intrinsicContentSize.height, -commomButton.imageView.intrinsicContentSize.width, 0, 0);
            
            [self.contentView addSubview:commomButton];
            
            [commomButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace * 2 + (i%columns) * (60 + (kScreenWidth - hSpace * 4 - 60 * 4)/3));
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(vSpace * 1 + (i/columns)*(((self.contentView.width-(hSpace * 2 * 5))/4) + vSpace * 2));
                make.width.mas_equalTo(60);
                make.height.mas_equalTo(80);
            }];
            
            [commomButton addTarget:self action:@selector(commonHandle:) forControlEvents:UIControlEventTouchUpInside];
            commomButton.restorationIdentifier = [NSString stringWithFormat:@"%@%d",@"commomBtnRestorationID",i];
        }
    }
    return self;
}

#pragma mark - lazy load

-(NSArray *)infoArray{
    if(!_infoArray){
        _infoArray = [[NSArray alloc]init];
        _infoArray = @[@{@"title" : @"关注", @"image" : @"profile_my_follow"},
                       @{@"title" : @"消息通知", @"image" : @"profile_msg_notification"},
                       @{@"title" : @"收藏", @"image" : @"profile_v2_my_favorite"},
                       @{@"title" : @"浏览历史", @"image" : @"profile_v2_my_history"},
                       @{@"title" : @"钱包", @"image" : @"profile_v2_my_wallet"},
                       @{@"title" : @"用户反馈", @"image" : @"profile_user_feedback"},
                       @{@"title" : @"免流服务", @"image" : @"profile_system_config"},
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

#pragma mark - 点击事件

-(void)commonHandle:(UIButton *)sender{
    if([sender.restorationIdentifier isEqualToString:@"commomBtnRestorationID0"]){
        NSLog(@"点击了0");
        _focusVC = [[focusViewController alloc]init];
        [[self getCurrentViewController].navigationController pushViewController:_focusVC animated:YES];
    }else if([sender.restorationIdentifier isEqualToString:@"commomBtnRestorationID1"]){
        MessageViewController *messageVC = [[MessageViewController alloc]init];
        [[self getCurrentViewController].navigationController pushViewController:messageVC animated:YES];
    }
    
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
