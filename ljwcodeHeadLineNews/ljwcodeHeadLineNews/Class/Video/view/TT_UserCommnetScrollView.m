//
//  TT_UserCommnetScrollView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/22.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_UserCommnetScrollView.h"
#import <Masonry/Masonry.h>
#import "TT_UserCommentTableViewCell.h"

@interface TT_UserCommnetScrollView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UIView *TT_UserCommentHeaderView;

@property(nonatomic,strong)UITableView *TT_UserCommnetTableView;

@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation TT_UserCommnetScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.TT_UserCommentHeaderView];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"close_comment"] forState:UIControlStateNormal];
        [self.TT_UserCommentHeaderView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.centerY.mas_equalTo(self.TT_UserCommentHeaderView);
            make.width.mas_equalTo(30);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        [self.TT_UserCommentHeaderView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.TT_UserCommentHeaderView);
            make.top.mas_equalTo(vSpace/2);
            make.bottom.mas_equalTo(-vSpace/2);
            make.width.mas_greaterThanOrEqualTo(kScreenWidth * 0.2);
        }];
        
        
    }
    return self;
}

#pragma mark ------ UITableViewDelegate && UITableViewDataSource

#pragma mark ------ UIScrollViewDelegate

#pragma mark ------ lazy load

-(UIView *)TT_UserCommentHeaderView{
    if(!_TT_UserCommentHeaderView){
        _TT_UserCommentHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.1)];
    }
    return _TT_UserCommentHeaderView;
}

-(UITableView *)TT_UserCommnetTableView{
    if(!_TT_UserCommnetTableView){
        _TT_UserCommnetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TT_UserCommentHeaderView.frame), kScreenWidth, CGRectGetHeight(self.frame) - CGRectGetHeight(self.TT_UserCommentHeaderView.frame)) style:UITableViewStylePlain];
        _TT_UserCommnetTableView.delegate = self;
        _TT_UserCommnetTableView.dataSource = self;
        
        UINib *userCommentNib = [UINib nibWithNibName:NSStringFromClass([TT_UserCommentTableViewCell class]) bundle:nil];
        
    }
    return _TT_UserCommnetTableView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
