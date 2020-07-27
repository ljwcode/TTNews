//
//  moreSettingTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "moreSettingTableViewCell.h"
#import "buttonStyleTwo.h"
#import <Masonry.h>

@interface moreSettingTableViewCell()

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,weak)UIButton *moreSettingButton;

@property(nonatomic,strong)NSArray *infoArray;

@end

static CGFloat Vspace = 30;
static CGFloat Hspace = 30;
static CGFloat buttonWidth = 50;
static CGFloat buttonHeight = 50;
static int columns = 4;

#define isMoreSettingButtonFrame(i) CGRectMake(Hspace+(i%columns)*(Hspace+buttonWidth), CGRectGetHeight(self.titleLabel.frame)+Vspace+(i/columns)*(Vspace+buttonHeight)+self.titleLabel.frame.origin.y+Vspace*2, buttonWidth, buttonHeight)

@implementation moreSettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(Hspace);
            make.top.mas_equalTo(self.contentView).offset(Vspace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
            
        }];
        
        for(int i = 0;i < self.infoArray.count;i++){
            buttonStyleTwo *moreSettingButton = [[buttonStyleTwo alloc]init];
            moreSettingButton.frame = isMoreSettingButtonFrame(i);
            [moreSettingButton configrueTitle:self.infoArray[i][@"title"] img:[UIImage imageNamed:self.infoArray[i][@"image"]]];
            [self.contentView addSubview:moreSettingButton];
            _moreSettingButton = moreSettingButton;
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
