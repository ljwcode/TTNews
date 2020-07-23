//
//  screeningHallTableViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "screeningHallTableViewCell.h"
#import <UIView+Frame.h>
#import "buttonStyleOne.h"
#import <Masonry/Masonry.h>
#import "videoInfoTableViewCell.h"

@interface screeningHallTableViewCell()<UIScrollViewDelegate>

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,weak)buttonStyleOne *showMoreButton;

@property(nonatomic,weak)UIScrollView *scrollView;

@property(nonatomic,strong)NSMutableArray *dataSourceArray;

@property(nonatomic,assign)CGFloat cellWidth;

@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,weak)videoInfoTableViewCell *infoCell;

@end

static CGFloat space = 10;
@implementation screeningHallTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _cellWidth = self.width - 3 * space / 3;
        _cellHeight = self.scrollView.height;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(space);
            make.top.mas_equalTo(self.mas_left).offset(space);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(30);
        }];
        
        [self.showMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-space);
            make.top.mas_equalTo(self.titleLabel);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(45);
        }];
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(space);
            make.width.mas_equalTo(self.width - space);
            make.height.mas_equalTo(self.height - 3 * space - self.titleLabel.height);
        }];
        
//        [self.infoCell mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left
//        }];
    }
    return self;
}

-(videoInfoTableViewCell *)infoCell{
    if(!_infoCell){
        videoInfoTableViewCell *infoCell = [[videoInfoTableViewCell alloc]init];
        _infoCell = infoCell;
    }
    return _infoCell;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"放映厅";
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont systemFontOfSize:16.f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

-(UIButton *)showMoreButton{
    if(!_showMoreButton){
        buttonStyleOne *button = [[buttonStyleOne alloc]init];
        [button configureTitle:@"查看全部" img:[UIImage imageNamed:@"arrow_morelogin_profile_5x8_"]];
        [self addSubview:button];
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
        [self addSubview:scrollView];
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
