//
//  TTArticleSearchHistoryHeaderCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchHistoryHeaderCell.h"

@interface TTArticleSearchHistoryHeaderCell()

@property(nonatomic,assign)BOOL isShowDel;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIButton *actionBtn;

@property(nonatomic,strong)UIButton *delAllBtn;

@property(nonatomic,strong)UIButton *completeBtn;

@property(nonatomic,strong)SSThemedButton *moreHistoryBtn;

@end

@implementation TTArticleSearchHistoryHeaderCell

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.isShowDel = false;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(vSpace);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.moreHistoryBtn];
        [self.moreHistoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(0);
            make.centerY.mas_equalTo(self.titleLabel);
            make.width.height.mas_equalTo(15);
        }];
        
        [self.contentView addSubview:self.actionBtn];
        [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-hSpace);
            make.top.mas_equalTo(vSpace);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.completeBtn];
        [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-hSpace);
            make.top.mas_equalTo(vSpace);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(20);
        }];

        [self.contentView addSubview:self.delAllBtn];
        [self.delAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.actionBtn.mas_left).offset(-hSpace);
            make.top.mas_equalTo(self.actionBtn);
            make.width.height.mas_equalTo(self.titleLabel);
        }];
    }
    return self;
}

#pragma mark ----- lazy load

-(SSThemedButton *)moreHistoryBtn{
    if(!_moreHistoryBtn){
        _moreHistoryBtn = [SSThemedButton buttonWithType:UIButtonTypeCustom];
        [_moreHistoryBtn setImage:[UIImage imageNamed:@"account_icon_arrowdown_old_night"] forState:UIControlStateNormal];
        [_moreHistoryBtn addTarget:self action:@selector(moreHistoryHandle:) forControlEvents:UIControlEventTouchUpInside];
        [_moreHistoryBtn setImage:[UIImage imageNamed:@"chatroom_icon_up"] forState:UIControlStateSelected];
    }
    return _moreHistoryBtn;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"搜索历史";
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _titleLabel;
}

-(UIButton *)actionBtn{
    if(!_actionBtn){
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(actionHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

-(UIButton *)completeBtn{
    if(!_completeBtn){
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_completeBtn addTarget:self action:@selector(completeHandle:) forControlEvents:UIControlEventTouchUpInside];
        [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _completeBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_completeBtn setHidden:true];
    }
    return _completeBtn;
}

-(UIButton *)delAllBtn{
    if(!_delAllBtn){
        _delAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delAllBtn setTitle:@"全部删除" forState:UIControlStateNormal];
        [_delAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _delAllBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        _delAllBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _delAllBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_delAllBtn setHidden:true];
    }
    return _delAllBtn;
}

#pragma mark ---- 响应事件

-(void)actionHandle:(UIButton *)sender{
    sender.selected  = !sender.selected;
    if(sender.selected){
        self.isShowDel = true;
        [self.delAllBtn setHidden:false];
        [self.actionBtn setHidden:true];
        [self.completeBtn setHidden:false];
    }
}

-(void)completeHandle:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        self.isShowDel = false;
        [self.delAllBtn setHidden:true];
        [self.actionBtn setHidden:false];
        [self.completeBtn setHidden:true];
    }
}

-(void)moreHistoryHandle:(UIButton *)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(showMoreSearchHistory)]){
        [self.delegate showMoreSearchHistory];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
