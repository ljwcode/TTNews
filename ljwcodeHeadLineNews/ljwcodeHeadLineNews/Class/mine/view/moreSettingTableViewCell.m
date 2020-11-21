//
//  moreSettingTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "moreSettingTableViewCell.h"

@interface moreSettingTableViewCell()

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,weak)UIButton *moreSettingButton;

@property(nonatomic,strong)NSArray *infoArray;

@end

static int columns = 4;

@implementation moreSettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(hSpace * 3);
            make.top.mas_equalTo(self.contentView).offset(vSpace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
            
        }];
        
        for(int i = 0;i < self.infoArray.count;i++){
            UIButton *moreSettingButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [moreSettingButton setTitle:self.infoArray[i][@"title"] forState:UIControlStateNormal];
            [moreSettingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            moreSettingButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
            [moreSettingButton.titleLabel sizeToFit];
            [moreSettingButton setImage:[UIImage imageNamed:self.infoArray[i][@"image"]] forState:UIControlStateNormal];
            moreSettingButton.imageEdgeInsets = UIEdgeInsetsMake(-moreSettingButton.titleLabel.intrinsicContentSize.height, 0, 0, -moreSettingButton.titleLabel.intrinsicContentSize.width);
            moreSettingButton.titleEdgeInsets = UIEdgeInsetsMake(moreSettingButton.imageView.intrinsicContentSize.height, -moreSettingButton.imageView.intrinsicContentSize.width, 0, 0);
            [self.contentView addSubview:moreSettingButton];
            _moreSettingButton = moreSettingButton;
            
            [moreSettingButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace * 2 + (i%columns)*(hSpace * 2 * 1.5+((self.contentView.width-(hSpace * 2 * 5))/4)));
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(vSpace * 1 + (i/columns)*(((self.contentView.width-(hSpace * 2 * 5))/4) + vSpace * 2));
                make.width.height.mas_equalTo(60);
            }];
        }
    }
    return self;
}

-(NSArray *)infoArray{
    if(!_infoArray){
        _infoArray = [[NSArray alloc]init];
        _infoArray = @[@{@"title" : @"超级会员",@"image" : @"profile_v2_my_comment"},
                       @{@"title" : @"圆梦公寓",@"image" : @"profile_v2_my_comment"},
                       @{@"title" : @"夜间模式", @"image" : @"profile_v2_my_comment"},
                       @{@"title" : @"评论",@"image" : @"profile_v2_my_comment"},
                       @{@"title" : @"点赞",@"image" : @"profile_v2_my_comment"},
                       @{@"title" : @"扫一扫",@"image" : @"profile_scan_code"},
                       @{@"title" : @"预约",@"image" : @"profile_v2_my_comment"},
                       @{@"title" : @"网络推广",@"image" : @"profile_v2_my_comment"}
        ];
    }
    return _infoArray;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"更多设置";
        titleLabel.font = [UIFont systemFontOfSize:18.f];
        titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
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
