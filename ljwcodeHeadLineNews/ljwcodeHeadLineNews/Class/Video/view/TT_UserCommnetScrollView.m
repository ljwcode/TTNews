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
#import "TT_VideoCommentModel.h"

@interface TT_UserCommnetScrollView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *TT_CommentScrollView;

@property(nonatomic,strong)UIView *TT_UserCommentHeaderView;

@property(nonatomic,strong)UIView *TT_CommentFooterView;

@property(nonatomic,strong)UITableView *TT_UserCommnetTableView;

@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation TT_UserCommnetScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.TT_CommentScrollView];
        [self.TT_CommentScrollView addSubview:self.TT_UserCommentHeaderView];
        
        [self addSubview:self.TT_UserCommnetTableView];
        
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
        
        [self.TT_CommentScrollView addSubview:self.TT_CommentFooterView];
        
        UITextField *CommentTextField = [[UITextField alloc]init];
        CommentTextField.layer.borderColor = [UIColor grayColor].CGColor;
        CommentTextField.layer.borderWidth = 1.f;
        CommentTextField.layer.cornerRadius = 10.f;
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:@"写评论..." attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11.f],NSForegroundColorAttributeName : [UIColor blackColor]}];
        CommentTextField.attributedText = attrString;
        CommentTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        leftImgView.image = [UIImage imageNamed:@"hts_vp_write_new"];
        CommentTextField.leftViewMode = UITextFieldViewModeAlways;
        [CommentTextField.leftView addSubview:leftImgView];
        
        CommentTextField.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        UIImageView *rightImgView = [[UIImageView alloc]initWithFrame:CommentTextField.rightView.bounds];
        rightImgView.image = [UIImage imageNamed:@"tsv_comment_footer_emoji"];
        [CommentTextField.rightView addSubview:rightImgView];
        CommentTextField.rightViewMode = UITextFieldViewModeAlways;
        
        [self.TT_CommentFooterView addSubview:CommentTextField];
        [CommentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace * 2);
            make.right.mas_equalTo(-hSpace * 2);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
        
    }
    return self;
}

#pragma mark ------ UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = NSStringFromClass([TT_UserCommentTableViewCell class]);
    TT_UserCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[TT_UserCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    TT_VideoCommentModel *model = self.dataArray[indexPath.row];
    cell.commentModel = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark ------ UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

#pragma mark ------ lazy load

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
}

-(UIView *)TT_UserCommentHeaderView{
    if(!_TT_UserCommentHeaderView){
        _TT_UserCommentHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.1)];
        _TT_UserCommentHeaderView.layer.borderColor = [UIColor grayColor].CGColor;
        _TT_UserCommentHeaderView.layer.borderWidth = 1.f;
    }
    return _TT_UserCommentHeaderView;
}

-(UIView *)TT_CommentFooterView{
    if(!_TT_CommentFooterView){
        _TT_CommentFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) * 0.9, kScreenWidth, CGRectGetHeight(self.frame) * 0.1)];
        _TT_CommentFooterView.layer.borderColor = [UIColor grayColor].CGColor;
        _TT_CommentFooterView.layer.borderWidth = 1.f;
    }
    return _TT_CommentFooterView;
}

-(UITableView *)TT_UserCommnetTableView{
    if(!_TT_UserCommnetTableView){
        _TT_UserCommnetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TT_UserCommentHeaderView.frame), kScreenWidth, CGRectGetHeight(self.frame) - CGRectGetHeight(self.TT_UserCommentHeaderView.frame)) style:UITableViewStylePlain];
        _TT_UserCommnetTableView.delegate = self;
        _TT_UserCommnetTableView.dataSource = self;
        
        UINib *userCommentNib = [UINib nibWithNibName:NSStringFromClass([TT_UserCommentTableViewCell class]) bundle:nil];
        [_TT_UserCommnetTableView registerNib:userCommentNib forCellReuseIdentifier:NSStringFromClass([TT_UserCommentTableViewCell class])];
    }
    return _TT_UserCommnetTableView;
}

-(UIScrollView *)TT_CommentScrollView{
    if(!_TT_CommentScrollView){
        _TT_CommentScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _TT_CommentScrollView.delegate = self;
        _TT_CommentScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
        
    }
    return _TT_CommentScrollView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
