//
//  screeningHallTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "screeningHallTableViewCell.h"
#import <UIView+Frame.h>
#import <Masonry/Masonry.h>
#import "videoInfoTableView.h"

@interface screeningHallTableViewCell()<UIScrollViewDelegate>

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,weak)UIButton *showMoreButton;

@property(nonatomic,weak)UIScrollView *scrollView;

@property(nonatomic,strong)NSMutableArray *dataSourceArray;

@property(nonatomic,assign)CGFloat cellWidth;

@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,weak)videoInfoTableView *infoView;

@end

static CGFloat space = 10;
@implementation screeningHallTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _cellWidth = self.width - 3 * space / 3;
        _cellHeight = self.scrollView.height;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(space);
            make.top.mas_equalTo(self.top).offset(space);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(80);
        }];
        
        [self.showMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-space);
            make.top.mas_equalTo(self.titleLabel);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(80);
        }];
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(-space);
            make.width.mas_equalTo(self.width - space);
            make.height.mas_equalTo(self.height - 3 * space - self.titleLabel.height);
        }];
        
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.scrollView.mas_left).offset(space);
            make.top.mas_equalTo(self.scrollView);
            make.bottom.mas_equalTo(self.scrollView);
        }];
    }
    return self;
}

-(videoInfoTableView *)infoView{
    if(!_infoView){
        videoInfoTableView *infoView = [[videoInfoTableView alloc]init];
        [self.scrollView addSubview:infoView];
        _infoView = infoView;
        
    }
    return _infoView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"放映厅";
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont systemFontOfSize:12.f];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

-(UIButton *)showMoreButton{
    if(!_showMoreButton){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"查看全部" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"arrow_right_setup_12x16_"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.intrinsicContentSize.width-20);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.intrinsicContentSize.width-30, 0, 0);
        [self.contentView addSubview:button];
        _showMoreButton = button;
    }
    return _showMoreButton;
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(_cellWidth * _dataSourceArray.count + space * _dataSourceArray.count + 1,_scrollView.height);
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = YES;
        scrollView.decelerationRate = 0.8;
        [self.contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
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
